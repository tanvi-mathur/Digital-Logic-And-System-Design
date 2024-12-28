import sys

gh={}
gw={}
file= str(sys.argv[1])
condn=True
with open(file, 'r') as f:
    inp = f.readlines()
    lsth=[]
    lstw=[]
    c=0
    for i in inp:
        i=i.rstrip()
        l=i.split(' ')
        c+=1
        if (int(l[1])>100 or int(l[1])<=0) and (int(l[2])>100 or int(l[2])<=0) and c>1000:
            print('Invalid width/height/no. of gates')
            condn=False
            break
        lsth.append(l)
        lstw.append(l)
    lsth.sort(key=lambda x:(int(x[2]), int(x[1])))
    lstw.sort(key=lambda x:(int(x[1]), int(x[2])))
    
    for l in lsth[::-1]:
        gh[l[0]]=(int(l[1]), int(l[2]))
    for l in lstw[::-1]:
        gw[l[0]]=(int(l[1]), int(l[2]))

def main():
    widths = []
    heights=[]
    minA=0
    for i in gh.values():
        heights.append(i[1])
        minA+=i[1]*i[0]
    for i in gw.values():
        widths.append(i[0])

    recth=list(gh.keys())#sort by height
    rectw=list(gw.keys())
    #bdd=[width, height]
    gxyh={recth[0]: (0, 0), }
    gxyw={rectw[0]: (0, 0), }

    class bdd:
        def __init__(self, gxy, g):
            final_coord={}
            self.empty=[]
            for k, v in gxy.items():
                final_coord[k]=(gxy[k][0]+g[k][0], gxy[k][1]+g[k][1])
            self.final_x=[x[0] for x in final_coord.values()]
            self.final_y=[y[1] for y in final_coord.values()]
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
        def max_y(self, g=gh, gxy=gxyh):
            self.max_y=max([gate(g, gxy, k).yf for k in self.gates])
            return self.max_y

    binsh=[Level(0, 0, heights[0], 0)]
    binsw=[Level(0, 0, 0, widths[0])]

    def vertical_space(rect, l, gxy=gxyh, g=gh): #check if vertical space available, gate
        space_left = binsh[l].h-(gate(g, gxy, list(gxy.keys())[-1]).yf-binsh[l].y0)
        if space_left>rect.yf or space_left==rect.yf:
            return True
        return False
    def horiz_space(rect,l, gxy=gxyw, g=gw): #check if horizontal space available, rect: (w, h)
        space_left = binsw[l].w-(gate(g, gxy, list(gxy.keys())[-1]).xf-binsw[l].x0)
        if space_left>rect.xf or space_left==rect.xf:
            return True
        return False

    c=0
    lh=0
    for k, v in gh.items():
        lst = list(gxyh.keys()) 
        if not vertical_space(gate(gh, gxyh, lst[-1]), lh) and k not in lst:
            x=gate(gh, gxyh, lst[-1]).xf
            y=gate(gh, gxyh, lst[-1]).yi
            gxyh[k]=(x,y)
            binsh[lh].add_rect(k)
            c+=1   
        if vertical_space(gate(gh, gxyh, lst[-1]), lh) and k not in lst:
            x=gate(gh, gxyh, lst[-1]).xi
            y=gate(gh, gxyh, lst[-1]).yf
            gxyh[k]=(x,y)
            binsh[lh].add_rect(k)
            c+=1
        if gate(gh, gxyh, k).xf>minA**(0.5):
            lh+=1
            binsh.append(Level(0, binsh[-1].y0+binsh[-1].h, gh[list(gh.keys())[len(gxyh)-1]][1], 0))
            gxyh[k]=(0, binsh[-1].y0) 
            binsh[lh].add_rect(k)        

    lw=0
    c=0
    for k, v in gw.items():
        h = []
        lst = list(gxyw.keys()) 
        if not horiz_space(gate(gw, gxyw, lst[-1]), lw) and k not in lst:
            x=gate(gw, gxyw, lst[-1]).xi
            y=gate(gw, gxyw, lst[-1]).yf
            gxyw[k]=(x,y)
            binsw[lw].add_rect(k)
            c+=1
                
        if horiz_space(gate(gw, gxyw, lst[-1]), lw) and k not in lst:
            x=gate(gw, gxyw, lst[-1]).xf
            y=gate(gw, gxyw, lst[-1]).yi
            gxyw[k]=(x,y)
            binsw[lw].add_rect(k)
            c+=1 
        
        if gate(gw, gxyw, k).yf>minA**0.5:
            lw+=1
            binsw.append(Level(binsw[-1].x0+binsw[-1].w, 0, 0, gw[list(gw.keys())[len(gxyw)-1]][0], gxyw, gw))
            gxyw[k]=(binsw[-1].x0, 0)
            binsw[lw].add_rect(k)
            
    out= str(sys.argv[2])
    if bdd(gxyw, gw).area()<bdd(gxyh, gh).area():
        gxy=gxyw
        g=gw
    else:
        gxy=gxyh
        g=gh             
    with open(out, 'w') as f:
        f.write('bounding_box '+str(bdd(gxy, g).w())+' '+str(bdd(gxy, g).h())+'\n')
        for k, v in gxy.items():
            f.write(str(k)+' '+ str(v[0])+' '+str(v[1])+'\n')
    print("Packing efficiency: ", minA/bdd(gxy, g).area()*100, "%")
    
if condn==True:
    main()
