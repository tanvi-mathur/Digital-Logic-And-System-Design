import sys
import random
import copy
from itertools import product
import math

gh={}
gw={}
gA={}
file= str(sys.argv[1])

with open(file, 'r') as f:
    inp = f.readlines()
    lsth=[]
    lstw=[]
    lstA=[]
    pins={}
    pin=[]
    gate_pins=[]
    conn=[] #connections
    in_pins=[]
    in_gates=[]
    out_gates=[]
    out_pins=[]
    g_conn=[]
    c=0
    delay={}
    for i in inp:
        i=i.rstrip()
        l=i.split(' ')
        if l[0]=='wire':
            break
        c+=1     
    
    for i in inp[::2]:
        i=i.rstrip()
        l=i.split(' ')
        
        if l[0]=='wire_delay':
            wire_delay=int(l[1])
            break
        lsth.append(l)
    for i in inp[1::2]:
        i=i.rstrip()
        l=i.split(' ')
        if l[0]=='wire':
            break
            
        l1={}
        for j in range(2, len(l), 2):
            l1['p'+str(j//2)]=[int(l[j]), int(l[j+1])]
            pins[l[1]]=l1
            gate_pins.append([l[1], 'p'+str(j//2)])

    for i in inp[c:]:
        i=i.rstrip()
        l=i.split(' ')
        j=l[1:]
        l3=[]
        l4=[]
        for k in j:
            l5=k.split('.')
            l3.append(l5)
            l4.append(l5[0])
        conn.append(l3)
        in_pins.append(l3[0])
        in_gates.append(l3[0][0])
        out_pins.append(l3[1])
        out_gates.append(l3[1][0])
        g_conn.append(l4)

    g1=[]
    g2=[]
    for c in conn:
        g1.append(c[0][0])
        g2.append(c[1][0])

    lsth.sort(key=lambda x:(int(x[2]), int(x[1])))
    
    for l in lsth[::-1]:
        gh[l[0]]=(int(l[1]), int(l[2]))
        delay[l[0]]=(int(l[3]))

widths = []
heights=[]
minA=0
for i in gh.values():
    heights.append(i[1])
    minA+=i[1]*i[0]
for i in gh.values():
    widths.append(i[0])
recth=list(gh.keys())#sort by height
gxyh={recth[0]: [0, 0], }
paths=[]
primary_inputs=[]
primary_outputs=[]
for g in gate_pins:
    if g not in in_pins and g not in out_pins:
        if g[0] not in out_gates:
            primary_inputs.append(g)
        else:
            primary_outputs.append(g)

#bdd=[width, height]
gxyh={recth[0]: [0, 0], }
critical_path=[]
def wire_length(gate): #gate: [['g', 'p'], ['g', 'p']]
    c1=[gxyh[gate[0][0]][0]+pins[gate[0][0]][gate[0][1]][0], gxyh[gate[0][0]][1]+pins[gate[0][0]][gate[0][1]][1]] #coordinates of pins
    c2=[gxyh[gate[1][0]][0]+pins[gate[1][0]][gate[1][1]][0], gxyh[gate[1][0]][1]+pins[gate[1][0]][gate[1][1]][1]]
    return abs(c1[0]-c2[0])+abs(c1[1]-c2[1])

def min_wire(gate):
    c1=[gxyh[gate[0][0]][0]+pins[gate[0][0]][gate[0][1]][0], gxyh[gate[0][0]][1]+pins[gate[0][0]][gate[0][1]][1]]
    c2_right=[gxyh[gate[0][0]][0]+gh[gate[0][0]][0]+pins[gate[1][0]][gate[1][1]][0], gxyh[gate[0][0]][1]+pins[gate[1][0]][gate[1][1]][1]]
    c2_left=[gxyh[gate[0][0]][0]-gh[gate[1][0]][0]+pins[gate[1][0]][gate[1][1]][0], gxyh[gate[0][0]][1]+pins[gate[1][0]][gate[1][1]][1]]
    c2_up=[gxyh[gate[0][0]][0]+pins[gate[1][0]][gate[1][1]][0], gxyh[gate[0][0]][1]+gh[gate[0][0]][1]+pins[gate[1][0]][gate[1][1]][1]]
    c2_down=[gxyh[gate[0][0]][0]+pins[gate[1][0]][gate[1][1]][0], gxyh[gate[0][0]][1]-gh[gate[0][0]][1]+pins[gate[1][0]][gate[1][1]][1]]
    lengths=[abs(c1[0]-c2_right[0])+abs(c1[1]-c2_right[1]), abs(c1[0]-c2_left[0])+abs(c1[1]-c2_left[1]), abs(c1[0]-c2_up[0])+abs(c1[1]-c2_up[1]), abs(c1[0]-c2_down[0])+abs(c1[1]-c2_down[1])]
    if lengths[0]==min(lengths):
        return 'right'
    elif lengths[1]==min(lengths):
        return 'left'
    elif lengths[2]==min(lengths):
        return 'up'
    else:
        return 'down'  
def gate_connectivity():
    wire_count={}
    for g1, g2 in g_conn:
        pair = tuple(sorted((g1, g2)))
        if pair in wire_count:
            wire_count[pair] += 1
        else:
            wire_count[pair] = 1
                    
    return wire_count
s=0
for k, v in gate_connectivity().items():
    s+=v
avg_count=s/len(gate_connectivity())

class bdd:
    def __init__(self, gxy, g):
        final_coord={}
        for k, v in gxy.items():
            final_coord[k]=(gxy[k][0]+g[k][0], gxy[k][1]+g[k][1])
        self.final_x=[x[0] for x in final_coord.values()]
        self.final_y=[y[1] for y in final_coord.values()]
        self.length=0
        self.d=0
    def w(self):
        self.w=max(self.final_x)
        return self.w
    def h(self):
        self.h = max(self.final_y)
        return self.h
    def area(self):
        self.h = max(self.final_y)
        self.w=max(self.final_x)
        self.area = self.h*self.w
        return self.area
    def total_wire(self, c):
        self.length=0
        for g in c:
            self.length+=wire_length(g)
        return self.length
def total_wire(c):
    length=0
    for g in c:
        length+=wire_length(g)
    return length

class gate:
    def __init__(self, g, gxy, k):
        
        self.xi = gxy[k][0]
        self.yi=gxy[k][1]
        self.xf=gxy[k][0]+g[k][0]
        self.yf=gxy[k][1]+g[k][1]
        self.w=g[k][0]
        self.h=g[k][1]

class Level:
    def __init__(self, x0, y0, h, w, gxy=gxyh, g=gh):
        self.x0=x0
        self.y0=y0
        self.h=h
        self.w=w
        self.gates=[]
    
    def add_rect(self, k):
        self.gates.append(k)

    def remove_rect(self, k):
        self.gates.remove(k)

binsh=[Level(0, 0, heights[0], 0)]

binsh[0].add_rect(list(gxyh.keys())[0])

c=0
lh=0
for k, v in gh.items():
    if k==list(gh.keys())[0]:
        continue
    lst = list(gxyh.keys()) 
    if k not in lst:
        x=gate(gh, gxyh, lst[-1]).xf
        y=gate(gh, gxyh, lst[-1]).yi
        gxyh[k]=[x,y]
        c+=1  
        binsh[lh].add_rect(k) 
    
    if gate(gh, gxyh, k).xf>minA**0.5:
        lh+=1
        binsh.append(Level(0, binsh[-1].y0+binsh[-1].h, gh[list(gh.keys())[len(gxyh)-1]][1], 0))
        gxyh[k]=[0, binsh[-1].y0] 
        binsh[lh].add_rect(k)
        binsh[lh-1].remove_rect(k)
        c+=1

def swap_levels(l1, l2, binsh=binsh, gxyh=gxyh):
    if l1 == l2:
        return   

    h1=binsh[l1].h
    h2=binsh[l2].h
    binsh[l1].h, binsh[l2].h=h2, h1
    binsh[l1].gates, binsh[l2].gates=binsh[l2].gates, binsh[l1].gates
    
    if l1<l2:
        #binsh[l1+1].y0=binsh[l1].h+binsh[l1].y0
        for l in range(l1+1, l2+1):
            binsh[l].y0=binsh[l-1].h+binsh[l-1].y0
            for g in binsh[l].gates:
                gxyh[g][1]=binsh[l].y0
        for g1 in binsh[l1].gates:  
            gxyh[g1][1]=binsh[l1].y0
            
        for g2 in binsh[l2].gates:
            gxyh[g2][1]=binsh[l2].y0
            
    elif l1>l2:
        for l in range(l2+1, l1+1):
            binsh[l].y0=binsh[l-1].h+binsh[l-1].y0
            for g in binsh[l].gates:
                gxyh[g][1]=binsh[l].y0
        for g1 in binsh[l1].gates:  
            gxyh[g1][1]=binsh[l1].y0
            
        for g2 in binsh[l2].gates:
            gxyh[g2][1]=binsh[l2].y0
    
    
def swap_gates_in_level(g1, g2, l, b=binsh, gxy=gxyh):
    
    c1=b[l].gates.index(g1)
    c2=b[l].gates.index(g2)
    if c1==c2:
        return
    gxy[g1], gxy[g2]=gxy[g2], gxy[g1]
    b[l].gates[c1], b[l].gates[c2]=b[l].gates[c2], b[l].gates[c1]     
    
    if c1<c2:
        for g in range(c1+1, c2+1):
            w=gh[g2][0]-gh[g1][0]
            if w<0:
                gxy[b[l].gates[g]][0]-=abs(w)
            elif w>0:
                gxy[b[l].gates[g]][0]+=abs(w)
        
        for g in range(c2+1, len(b[l].gates)):
            
            gxy[b[l].gates[g]][0]+=(gh[g1][0]-gh[g2][0]) 
    elif c2<c1:
        for g in range(c2+1, c1+1):
            gxy[b[l].gates[g]][0]+=gh[g1][0]-gh[g2][0]
        
        for g in range(c1+1, len(b[l].gates)):

            gxy[b[l].gates[g]][0]+=(gh[g2][0]-gh[g1][0])


def rearrange(conn, binsh=binsh, gxyh=gxyh): 
    memo=[]  
    memo_l=[]     
    for p in conn:
        
        g1, g2 = p[0][0], p[1][0]  
        for l in range(lh+1):
            if g2 in binsh[l].gates:
                l2=l
            if g1 in binsh[l].gates:
                l1=l 
        wire_priority = gate_connectivity().get((g1, g2), 0) + gate_connectivity().get((g2, g1), 0) 
         
        if (g1, g2) in memo or (g2, g1) in memo:
            continue
        memo.append((g1, g2))
        memo.append((g2, g1))
        
        wire_priority = gate_connectivity().get((g1, g2), 0) + gate_connectivity().get((g2, g1), 0) 
        try:
            if wire_priority >= avg_count:
                
                c2=binsh[l2].gates.index(g2)
                c1=binsh[l1].gates.index(g1)
                
                gxyh[g2][1]=gate(gh, gxyh, binsh[l1].gates[-1]).yi
                gxyh[g2][0]=gate(gh, gxyh, binsh[l1].gates[-1]).xf
                h2=[]
                h1=[]
                
                for g in binsh[l1].gates:
                    h1.append(gh[g][1])
                
                h1.sort(reverse=True)
                binsh[l2].gates.remove(g2)
                binsh[l1].add_rect(g2)
                
                if gh[g2][1]>h1[0]:
                    binsh[l1].h=gh[g2][1]
                    for l in range(l1+1, lh+1):
                        binsh[l].y0+=gh[g2][1]-h1[0]
                        for g in binsh[l].gates:
                            gxyh[g][1]+=gh[g2][1]-h1[0] 
                
                if min_wire(p)=='left':
                    if c1>=1:
                        swap_gates_in_level(binsh[l1].gates[c1-1], g2, l1)
                        memo.append((binsh[l1].gates[c1-1], g2))
                    else:
                        swap_gates_in_level(binsh[l1].gates[c1+1], g2, l1)
                        #swap_gates_in_level(g2, g1, l1)
                        memo.append((binsh[l1].gates[c1+1], g2))
                    
                        
                elif min_wire(p)=='right':
                        
                    if c1<=len(binsh[l1].gates)-2:
                        swap_gates_in_level(binsh[l1].gates[c1+1], g2, l1)
                        memo.append((binsh[l1].gates[c1+1], g2))
                        
                    else:
                        swap_gates_in_level(g1, g2, l1)
                for g in range(c2, len(binsh[l2].gates)):
                    gxyh[binsh[l2].gates[g]][0]-=gh[g2][0] 
                for g in binsh[l2].gates:
                    h2.append(gh[g][1]) 
                h2.sort(reverse=True)                      
                if gh[g2][1]>h2[0]:
                    binsh[l2].h=h2[0]
                    for l in range(l2+1, lh+1):
                        binsh[l].y0-=gh[g2][1]-h2[0]
                        for g in binsh[l].gates:
                            gxyh[g][1]-=(gh[g2][1]-h2[0])   
                       
            else:
                if min_wire(p)=='up':
                    if l1<lh+1:
                        swap_gates_in_level(binsh[l2].gates[max(len(binsh[l2].gates)-1, c1)], g2, l2)
                        swap_levels(l1+1, l2)
                        memo_l.append((l1+1, l2))
                        
                    else:
                        swap_gates_in_level(binsh[l2].gates[max(len(binsh[l2].gates)-1, c1)], g2, l2)
                        swap_levels(l1-1, l2)
                        swap_levels(l1, l1-1)
                        memo_l.append((l1-1, l2))
                        memo_l((l1, l1-1))
                elif min_wire(p)=='down':
                    if l1>0:
                        swap_gates_in_level(binsh[l2].gates[max(len(binsh[l2].gates)-1, c1)], g2, l2)
                        swap_levels(l1-1, l2)
                        memo_l.append((l1-1, l2))
                        
                    else:
                        swap_gates_in_level(binsh[l2].gates[max(len(binsh[l2].gates)-1, c1)], g2, l2)
                        swap_levels(l1+1, l2)
                        swap_levels(l1, l1+1)
                        memo_l.append((l1+1, l2))
                        memo_l.append((l1, l1+1))
        except (KeyError, IndexError):
                pass 

def total_delay(c, p):
    d=wire_delay*total_wire(c)
    gates=[]
    for g in p:
        if g[0] in gates:
            continue
        gates.append(g[0])
    for g in gates:
        d+=delay[g]
    return d
for c1 in range(len(conn)):
    l=[]
    if primary_inputs!=[] and primary_outputs!=[]:
        for i in primary_inputs: 
            if i[0] == conn[c1][0][0]:  
                l = [i] + conn[c1]
    
        for c2 in range(len(conn)): 
            if conn[c2] not in l :
                if l!=[]:
                    if l[-1] not in primary_outputs:
                        if conn[c2][0][0] == l[-1][0] and conn[c2][0]!=l[-1]:
                            l += conn[c2]  
                        elif conn[c2][0][0] == l[-1][0] and conn[c2][0]==l[-1]:
                            l+=[conn[c2][1]]

        for j in primary_outputs:
            if l!=[]:
                if j in l:
                    continue
                if l[-1][0]==j[0]:        
                    l.append(j)
                    break
        if l not in paths and l!=[]:
            paths.append(l)
    else:
        paths.append(conn[c1])

values={}
paths_conn=[]
only_conns=[]
for p in range(len(paths)):
    path_conn=[]
    for j in range(1, len(paths[p])):
        path_conn.append([paths[p][j-1], paths[p][j]])
    paths_conn.append(path_conn)

rearrange(conn)
for b in binsh:
    if len(b.gates)==0:
        for i in range(binsh.index(b)+1, lh+1):
            for g in binsh[i].gates:
                binsh[i].y0-=b.h
                gxyh[g][1]-=b.h
        lh-=1
        binsh.remove(b)
def critical():
    
    for p in range(len(paths_conn)): 
        only_conn=[] 
        for c in paths_conn[p]:
            if c[0][0]!=c[1][0]:
                only_conn.append(c)
        only_conns.append(only_conn)
    
    
    for p in range(len(paths_conn)):  
        gates=[]
        for g in paths[p]:
            if g[0] in gates:
                continue
            gates.append(g[0])
        
        try: 
            values[p]=wire_delay*total_wire(only_conns[p])
            for g in gates:
                values[p]+=delay[g]
            
        except (KeyError, IndexError):
            continue
    return values, paths, paths_conn
out= str(sys.argv[2])

values, paths, paths_conn=critical()
max_value=(0, paths[0], paths_conn[0])

for k, v in values.items():
    if v > max_value[0]:
        max_value=(v, paths[k], paths_conn[k])

gxy=gxyh
g=gh

with open(out, 'w') as f:
    f.write('bounding_box '+str(bdd(gxy, g).w())+' '+str(bdd(gxy, g).h())+'\n')
    f.write('critical_path ')
    memo=[]
    for k in max_value[1]:
        f.write(str(k[0])+'.'+str(k[1])+' ')
    f.write('\n')

    f.write('critical_path_delay '+str(max_value[0])+'\n')
    
    for k, v in gxy.items():
        f.write(str(k)+' '+ str(v[0])+' '+str(v[1])+'\n')
