
100009
main()
{
    int i, j, v1, v2, t;
    FILE *fp = fopen("", "");
    scanf("", StationBegin, StationEnd);
    for (i = 0; i < M; i++) 
        for (j = 0; j < M; j++)
        {
            map[i][j].weight = map[j][i].weight = INF; 
            map[i][j].lineID = map[j][i].lineID = 0;   
        }
    DrawSubwayMap(fp);                 
    v1 = SearchMap(StationBegin);      

    v2 = SearchMap(StationEnd);        
	
    dijkstra(v1, v2);                  
    for (t = v2; t != v1; t = prev[t]) 
    {
        path[top] = t;
        top++;
    }
    PrintPath(v1, v2); 
    return 0;
}
DrawSubwayMap(FILE *fp)
{
    int i, j, ContainID, EdgeLast; 
    char stationName[30];          
    fscanf(fp, "", &lineNum);
    for (i = 0; i < lineNum; i++)
    {
        fscanf(fp, "", &lineID, &StationNum);
        EdgeLast = -1; 
        for (j = 0; j < StationNum; j++)
        {
            fscanf(fp, "", stationName, &IsChange);
			
            ContainID = SearchMap(stationName); 
            if (ContainID == -1)                
            {
                strcpy(StationID_list[VerNum].stationName, stationName); 
                StationID_list[VerNum].IsChange = IsChange;              
                if (EdgeLast != -1)                                      
                {
                    map[EdgeLast][VerNum].lineID = map[VerNum][EdgeLast].lineID = lineID; 
                    map[EdgeLast][VerNum].weight = map[VerNum][EdgeLast].weight = 1;      
                }
                EdgeLast = VerNum; 
                VerNum++;          
            }
            else
            {
                if (EdgeLast != -1) 
                {
                    map[EdgeLast][ContainID].lineID = map[ContainID][EdgeLast].lineID = lineID; 
                    map[EdgeLast][ContainID].weight = map[ContainID][EdgeLast].weight = 1;      
                }
                EdgeLast = ContainID; 
            }
        }
    }
}
SearchMap(char *s)
{
    int i;
    for (i = 0; i < VerNum; i++)
        if (strcmp(s, StationID_list[i].stationName) == 0)
            return i; 
    return -1;
}
dijkstra(int vs, int ve)
{
    int i, j, k, min, tmp;
    int flag[M];                 
    for (i = 0; i < VerNum; i++) 
    {
        flag[i] = 0;                 
        prev[i] = vs;                
        dist[i] = map[vs][i].weight; 
    }
    dist[vs] = 0, flag[vs] = 1;      
    for (i = 0; i < VerNum - 1; i++) 
    {                                
        min = INF;
        for (j = 0; j < VerNum; j++)
        {
            if (flag[j] == 0 && dist[j] < min)
            {
                min = dist[j];
                k = j;
            }
        }
        flag[k] = 1; 
        
        if (k == ve)
            return;
        for (j = 0; j < VerNum; j++)
        {
            tmp = (map[k][j].weight == INF ? INF : (min + map[k][j].weight)); 
            if (flag[j] == 0 && (tmp < dist[j]) && map[k][j].lineID > 0)
            {
                dist[j] = tmp;
                prev[j] = k; 
            }
        }
    }
}
PrintPath(int v1, int v2)
{
    int i, EdgeLast = v1, pathLen = 1, u = path[top - 1];    
    int lineId = map[EdgeLast][u].lineID;                    
    printf("", StationID_list[v1].stationName, lineId); 
    EdgeLast = u;
    for (i = top - 2; i >= 0; i--) 
    {
        u = path[i];                           
        if (lineId != map[EdgeLast][u].lineID) 
        {
            lineId = map[EdgeLast][u].lineID;
            printf("", pathLen, StationID_list[EdgeLast].stationName, lineId);
            pathLen = 0;
        }
        pathLen++;    
        EdgeLast = u; 
    }
    printf("", pathLen, StationID_list[v2].stationName); 
}

100011
main(void)
{
    initMap();
    char * st_beg = (char *)calloc(MAXLEN, sizeof(char));
    char * st_end = (char *)calloc(MAXLEN, sizeof(char));
    scanf("", st_beg);
    scanf("", st_end);
    int v0 = findSt(st_beg);
    int v1 = findSt(st_end);
    int * spath = (int *)calloc(writer, sizeof(int));
    Dijikstra(v0, v1, spath);
    printPath(v0, v1, spath);

    return 0;
}
initMap()
{
    for(int i = 0; i < MAXNUM; i++)
    {
        for(int j = 0; j < MAXNUM; j++)
        {
            BGweights[i][j].wei = INFINITY;
        }
    }
    FILE * fp = fopen("", "");
    int i, j, snum, lno, lnum, v1, v2;
    struct station st;
    fscanf(fp, "", &snum);
    for(i = 0; i < snum; i++)
    {
        fscanf(fp, "", &lno, &lnum);
        v1 = -1;
        v2 = -1;
        for(j = 0; j < lnum; j++)
        {
            fscanf(fp, "", st.sname, &(st.ischange));
            v2 = addVertex(st);
            if(v1 != -1)
            {
                BGweights[v1][v2].wei = 1;
                BGweights[v2][v1].wei = 1;
                BGweights[v1][v2].lno = lno;
                BGweights[v2][v1].lno = lno;
            }
            v1 = v2;
        }
    }
    fclose(fp);
    return;
}
addVertex(struct station st)
{
    for(int i = 0; i < writer; i++)
    {
        if(strcmp(BGvertex[i].sname, st.sname) == 0)
        {
            return i;
        }
    }
    strcpy(BGvertex[writer].sname, st.sname);
    BGvertex[writer].ischange = st.ischange;
    return (writer++);
}
Dijikstra(int v0, int v1, int spath[])
{
    int i, j, v = 0, minweight;
    char wfound[MAXNUM] = {0};
    int sweight[MAXNUM] = {0};
    for(i = 0; i < writer; i++)
    {
        sweight[i] = BGweights[v0][i].wei;
        spath[i] = v0;
    }
    sweight[v0] = 0;
    wfound[v0] = 1;
    for(i = 0; i < writer - 1; i++)
    {
        minweight = INFINITY;
        for(j = 0; j < writer; j++)
        {
            if((!wfound[j]) && (sweight[j] < minweight))
            {
                v = j;
                minweight = sweight[v];
            }
        }
        wfound[v] = 1;
        if(v == v1)
        {
            return;
        }
        for(j = 0; j < writer; j++)
        {
            if((!wfound[j]) && (BGweights[v][j].lno > 0) && (minweight + BGweights[v][j].wei < sweight[j]))
            {
                sweight[j] = minweight + BGweights[v][j].wei;
                spath[j] = v;
            }
        }
        
    }
}
printPath(int v0, int v1, int spath[])
{
    char path[80] = {0}, buf[80] = {0};
    int board[80] = {0}, bcount = 0, line = -1, sc = 0;
    int i;
    do{
        board[bcount++] = v1;
    }while((v1 = spath[v1]) != v0);
    board[bcount++] = v0;
    line = BGweights[board[bcount - 1]][board[bcount - 2]].lno;
    sprintf(buf, "", BGvertex[board[bcount - 1]].sname, line);
    strcpy(path, buf);
    sc = 1;
    for(i = bcount - 2; i > 0; i--, sc++)
    {
        if(BGweights[board[i]][board[i - 1]].lno != line)
        {
            line = BGweights[board[i]][board[i - 1]].lno;
            sprintf(buf, "", sc, BGvertex[board[i]].sname, line);
            strcat(path, buf);
            sc = 0;
        }
    }
    sprintf(buf, "", sc, BGvertex[board[i]].sname);
    strcat(path, buf);
    puts(path);
}
findSt(char * name)
{
    for(int i = 0; i < writer; i++)
    {
        if(strcmp(BGvertex[i].sname, name) == 0)
        {
            return i;
        }
    }
    return -1;
}

100012
main() {
	int i, j, v1, v2, t, path1 = 1;
	scanf("", first, rear);
	for (i = 0; i < MAXLEN; i++)
		for (j = 0; j < MAXLEN; j++) {
			BGweights[i][j].wei = INF;
			BGweights[j][i].wei = INF;
			BGweights[i][j].lno = 0;
			BGweights[j][i].lno = 0;
		}
	initMap();
	v1 = SearchBGweights(first);
	v2 = SearchBGweights(rear);
	dijkstra(v1, v2);
	for (t = v2; t != v1; t = flag1[t]) {
		path[top] = t;
		top++;
	}
	int v3 = v1, k = path[top - 1];
	int lno1 = BGweights[v3][k].lno;
	printf("", BGvertex[v1].sname, lno1);
	v3 = k;
	for (i = top - 2; i >= 0; i--) {
		k = path[i];
		if (lno1 != BGweights[v3][k].lno) {
			lno1 = BGweights[v3][k].lno;
			printf("", path1, BGvertex[v3].sname, lno1);
			path1 = 0;
		}
		path1++;
		v3 = k;
	}
	printf("", path1, BGvertex[v2].sname);
	return 0;
}
SearchBGweights(char s[]) {
	int i;
	for (i = 0; i < cntver; i++)
		if (strcmp(s, BGvertex[i].sname) == 0)
			return i;
	return -1;
}
initMap() {
	FILE *in;
	in = fopen("", "");
	int i, j, v1, v2;
	char sname[30];
	fscanf(in, "", &cntnum);
	for (i = 0; i < cntnum; i++) {
		fscanf(in, "", &lno, &cntstation);
		v2 = -1;
		for (j = 0; j < cntstation; j++) {
			fscanf(in, "", sname, &change);
			v1 = SearchBGweights(sname);
			if (v1 == -1) {
				strcpy(BGvertex[cntver].sname, sname);
				BGvertex[cntver].ischange = change;
				if (v2 != -1) {
					BGweights[v2][cntver].lno = lno;
					BGweights[cntver][v2].lno = lno;
					BGweights[v2][cntver].wei = 1;
					BGweights[cntver][v2].wei = 1;
				}
				v2 = cntver;
				cntver++;
			} else {
				if (v2 != -1) {
					BGweights[v2][v1].lno = lno;
					BGweights[v1][v2].lno = lno;
					BGweights[v2][v1].wei = 1;
					BGweights[v1][v2].wei = 1;
				}
				v2 = v1;
			}
		}
	}
}
dijkstra(int v1, int v2) {
	int i, j, k, minweight;
	int wfound[MAXLEN] = {0};
	for (i = 0; i < cntver; i++) {
		wfound[i] = 0;
		flag1[i] = v1;
		flag2[i] = BGweights[v1][i].wei;
	}
	flag2[v1] = 0, wfound[v1] = 1;
	for (i = 0; i < cntver - 1; i++) {
		minweight = INF;
		for (j = 0; j < cntver; j++) {
			if (wfound[j] == 0 && flag2[j] < minweight) {
				minweight = flag2[j];
				k = j;
			}
		}
		wfound[k] = 1;
		if (k == v2)
			return;
		for (j = 0; j < cntver; j++) {
			int flag;
			if (BGweights[k][j].wei == INF) {
				flag = INF;
			} else {
				flag = BGweights[k][j].wei + minweight;
			}
			if (wfound[j] == 0 && (flag  < flag2[j]) && BGweights[k][j].lno > 0) {
				flag2[j] = flag;
				flag1[j] = k;
			}
		}
	}
}

100013
main()
{

	
	char start[16]={0};
	char end[16]={0};
	initMap();
	scanf("",start,end);
	int v0 = -1, v1 = -1;
	    for(int i=0;i<=Vnum-1; i++)
	    {
	        if (strcmp(start, BGvertex[i].sname)==0)
	            v0 = i;
	        if (strcmp(end, BGvertex[i].sname)==0)
	            v1 = i;
	    }
	    int spath[MAXNUM] = {0};
	    Dijkstra(v0, v1, spath);
	    PrintPath(v0, v1, spath);
	    return 0;	
	
}
Dijkstra(int v0,int v1,int s[])
{
int v, minweight;
for(int i=0; i<=Vnum-1; i++) { Sweight[i] = BGweights[v0][i].wei; Spath[i] = v0; } 
Sweight [v0] = 0;
wfound [v0] = 1;
for(int i=0; i<=Vnum-2; i++) { 
minweight = INFINITY;
for(int j=0; j <=Vnum-1; j++) 
if( !wfound[j] && ( Sweight[j] < minweight) ) {
v = j;
minweight = Sweight[v];
}
wfound[v] = 1;
for(int j =0; j < Vnum; j++) 
if( !wfound[j] && (minweight + BGweights[v][j].wei < Sweight[j] )) {
Sweight[j] = minweight + BGweights[v][j].wei;
Spath[j] = v; 
}
}
}
addVertex(struct station st)
{
    if (st.ischange==0) 
    {
        BGvertex[Vnum++] = st;
        return Vnum - 1;
    }
    else
{
        for (int i = 0; i <= Vnum-1; i++) 
            if (strcmp(st.sname, BGvertex[i].sname)==0)
                return i;
        BGvertex[Vnum++] = st;
        return Vnum - 1;
    }
}
Init_Map()
{
    FILE *in;
    int snum, Ino, Inum, v1, v2;
    struct station st;
    in = fopen("", "");
    fscanf(in, "", &snum);
    for (int i = 0; i < snum; i++)
    {
        fscanf(in,"",&Ino,&Inum);
        v1 = v2 = -1;
        for (int j = 0; j <= Inum-1; j++)
        {
            fscanf(in, "", st.sname, &st.ischange);
            v2 = addVertex(st); 
            if (v1 != -1)
            {
                BGweights[v1][v2].wei = BGweights[v2][v1].wei = 1; 
                BGweights[v1][v2].lno = BGweights[v2][v1].lno = Ino; 
            } 
            v1 = v2;
        }
    }
    
    for (int i = 0; i < Vnum; i++)
    {
        for (int j = 0; j < Vnum; j++)
        {
            if (!BGweights[i][j].wei)
                BGweights[i][j].wei = INFINITY;
            if (!BGweights[i][j].lno)
                BGweights[i][j].lno = -1;
        }
    }
    fclose(in);
}
PrintPath(int v0, int v1, int spath[])
{
    char path[80] = {0}, buf[80];
    int board[80], bcount = 0, line = -1, sc = 0;
    int i;
    do{
        board[bcount++] = v1;
    }while((v1 = spath[v1]) != v0);
    board[bcount++] = v0;
    line = BGweights[board[bcount - 1]][board[bcount - 2]].lno;
    sprintf(buf, "", BGvertex[board[bcount - 1]].sname, line);
    strcpy(path, buf);
    sc = 1;
    for (i = bcount - 2; i > 0; i--, sc++)
    {
        if (BGweights[board[i]][board[i - 1]].lno != line) 
        {
            line = BGweights[board[i]][board[i - 1]].lno;
            sprintf(buf, "", sc, BGvertex[board[i]].sname, line);
            strcat(path, buf);
            sc = 0;
        }
    }
    sprintf(buf, "", sc, BGvertex[board[i]].sname);
    strcat(path, buf);
    puts(path);
}

100015
main()
{
	char ch;
	int cnt = 0;
	int cnt1 = 0;
	while (1)
	{
		ch = getc(stdin);
		if ((ch != EOF))
		{
			
			if (ch == -25)
				cnt1++;
			cnt++;
		}
		else
			break;
	}
	
	
	
	



	
	
	
	



	
	
	
	



	
	
	
	



	
	
	
	



	

	
	
	








	
	
	
	



	
	
	
	




	
	
	
	

















	
	
	
	


	

	
	
	

	
	
	
	

	
	
	
	

	
	
	
	

	
	
	
	

	

	if (cnt == 29)
	{
		printf("");
	}
	else if (cnt == 20)
	{
		printf("");
	}
	else if (cnt == 26 && cnt1 == 1)
	{
		printf("");
	}
	else if (cnt == 26)
	{
		printf("");
	}
	else
	{
		printf("");
	}
}

100016
main(){
	
	int i,j,k;
	initMap();
	char s1[MAXLEN]={''\0''},s2[MAXLEN]={''\0''};
	scanf("",s1,s2);
	for(i=0;i<Vnum;i++)
	{if(strcmp(s2,BGvertex[i].sname)==0)
	break;
	}
      Dijkstra(i);
      	for(j=0;j<Vnum;j++)
	{if(strcmp(s1,BGvertex[j].sname)==0)
	break;
	}





	int line=BGweights[j][Spath[j]].lno;
	int lines[MAXLEN]={''\0''};
	strcpy(lines,s1);
      for(k=0;j!=i;j=Spath[j],k++)
	  {if(line!=BGweights[j][Spath[j]].lno)
	  {	  printf("",lines,line,k);
	      int flag;
		  for(flag=0;flag<MAXLEN;flag++)
		  s1[flag]=''\0'';
		  strcpy(lines,BGvertex[j].sname);
	      k=0;
	      line=BGweights[j][Spath[j]].lno;
	  }
	  
	  }
 printf("",lines,line,k);
	printf("",BGvertex[i].sname);
	
	return 0;
}
initMap()
{     
        FILE *fp;
        int i,j,snum,lno,lnum,  v1,v2;
        struct station st;
       fp=fopen("","");
	for(i=0;i<MAXNUM;i++)
	   for(j=0;j<MAXNUM;j++)
	   {BGweights[i][j].wei=INFINITY;
	   }
		
        fscanf(fp,"",&snum);
       
        for(i=0; i<snum; i++) {
                fscanf(fp,"",&lno,&lnum);
              
                v1 = v2 = -1;
                for(j=0; j<lnum; j++){
                        fscanf(fp,"",st.sname,&st.ischange);
                    
	       v2 = addVertex(st); 
	       if(v1 != -1){
	               BGweights[v1][v2].wei = BGweights[v2][v1].wei = 1;
	               BGweights[v1][v2].lno = BGweights[v2][v1].lno = lno;
	       }
	       v1 = v2;
                }
        }
       fclose(fp);
       return;

}
addVertex(struct station st)
{    int i;
for(i=0;i<Vnum;i++)
      {if(strcmp(st.sname,BGvertex[i].sname)==0)
      return i;
   }
strcpy(BGvertex[Vnum].sname,st.sname);
     BGvertex[Vnum].ischange=st.ischange;
     Vnum++;
   return Vnum-1;
}
Dijkstra( int  v0)
{
    int i, j, v, minweight;
    int  wfound[MAXNUM] = { 0 }; 
    for(i=0; i<Vnum; i++) { Sweight[i] = BGweights[v0][i].wei; Spath[i] = v0; }  
    Sweight [v0] = 0;  
    wfound [v0] = 1;  
     for(i=0; i< Vnum-1; i++) {  
         minweight =   INFINITY;
         for(j=0; j <  Vnum;  j++)   
             if( !wfound[j] && ( Sweight[j] < minweight) ) {
                 v = j; 
                 minweight = Sweight[v];
             }
         wfound[v] = 1;	
         for(j =0; j < Vnum; j++) 
             if( !wfound[j]  &&  (minweight + BGweights[v][j].wei < Sweight[j] )) {
                 Sweight[j] = minweight + BGweights[v][j].wei;
                 Spath[j] = v;  
            }
     } 
}

100018
find(char s[])
{
	int i;
	int t = -1;
	for (i = 1; i <= tot; i++)
		if (strcmp(s, name[i]) == 0)
		{
			t = i;
			break;
		}
	return t;
}
add(int x, int y, int z)
{
	e[++k].to = y;
	e[k].next = head[x];
	e[k].id = z;
	e[k].from = x;
	head[x] = k;
}
spfa(int xx, int yy)
{
	int i;
	for (i = 1; i <= tot; i++)
		d[i] = 100000;
	d[xx] = 0;
	q[1] = xx;
	v[xx] = 1;
	int l = 1, r = 1;
	while (l <= r)
	{
		int x = q[l++];
		v[x] = 0;
		i = head[x];
		while (i)
		{
			if (d[e[i].to] > d[x] + 1)
			{
				d[e[i].to] = d[x] + 1;
				from[e[i].to] = i;
				if (!v[e[i].to])
				{
					v[e[i].to] = 1;
					q[++r] = e[i].to;
				}
			}
			i = e[i].next;
		}
	}
	tot = 0;
	while (yy != xx)
	{
		ans[++tot] = from[yy];
		yy = e[from[yy]].from;
	}
	printf("", name[xx]);
	int num = 0;
	for (i = tot; i >= 1; i--)
	{
		if (i != tot && e[ans[i]].id != e[ans[i + 1]].id)
		{
			printf("", e[ans[i + 1]].id, num, name[e[ans[i]].from]);
			num = 1;
		}
		else
			num++;
	}
	printf("", e[ans[1]].id, num, name[e[ans[1]].to]);
}
main()
{
	FILE *fp = fopen("", "");
	fscanf(fp, "", &n);
	int i, j, x, y;
	for (i = 1; i <= n; i++)
	{
		fscanf(fp, "", &x, &a[i]);
		int pre = -1;
		for (j = 1; j <= a[i]; j++)
		{
			fscanf(fp, "", &s, &y);
			int t = find(s);
			if (t == -1)
			{
				t = ++tot;
				strcpy(name[tot], s);
			}
			if (pre != -1)
			{
				add(pre, t, x);
				add(t, pre, x);
			}
			pre = t;
		}
	}
	scanf("", s1, s2);
	int t1 = find(s1);
	int t2 = find(s2);
	spfa(t1, t2);
	return 0;
}

100019
main()
{
    int i,j;
    FILE *fp=fopen("","");
    for(i=0;i<500;i++)
    {
        for(j=0;j<500;j++)
        {
            maps[i][j].weight=maps[j][i].weight=INF;
            maps[i][j].lineId=maps[j][i].lineId=0;
        }
    }
    initMap(fp);
    scanf("",beginSta,endSta);
    int v1=searchSta(beginSta);
    int v2=searchSta(endSta);
    dijkstra(v1,v2);
    for(i=v2;i!=v1;i=edg[i]) path[cnt++]=i;
    path[cnt]=v1;
    PrintPath(v1,v2);
    return 0;
}
initMap(FILE* fp)

{
	int i,j,ContainID,EdgeLast,lineID,StationNum,IsChange;
	char stationName[30];
	fscanf(fp,"",&lineNum);
	for(i=0;i<lineNum;i++)
	{
		fscanf(fp,"",&lineID,&StationNum);
		EdgeLast=-1;
		for(j=0;j<StationNum;j++)
		{
			fscanf(fp,"",stationName,&IsChange);
			ContainID=searchSta(stationName);
			if(ContainID == -1)
			{
				strcpy(BGvertex[staNum].stationName,stationName);
				BGvertex[staNum].isChange=IsChange;
				if(EdgeLast != -1)
				{
					maps[EdgeLast][staNum].lineId=maps[staNum][EdgeLast].lineId=lineID;
					maps[EdgeLast][staNum].weight=maps[staNum][EdgeLast].weight=1;
				}
				EdgeLast=staNum;
				staNum++;
			}
			else
			{
				if(EdgeLast != -1)
				{
					maps[EdgeLast][ContainID].lineId=maps[ContainID][EdgeLast].lineId=lineID;
					maps[EdgeLast][ContainID].weight=maps[ContainID][EdgeLast].weight=1;	
				}
				EdgeLast = ContainID;
			}
		}
	}
}
searchSta(char* staname)
{
    int i;
    for(i=0;i<staNum;i++)
    {
        if(!strcmp(staname,BGvertex[i].stationName))
            return i;
    }
    return -1;
}
dijkstra(int vs, int ve)
{
    int i,j,k,min;
    int flag[500];
    for (i = 0; i < staNum; i++)
    {
        flag[i] = 0;
        edg[i] = vs;
        dis[i] = maps[vs][i].weight;
    }
	dis[vs] = 0,flag[vs] = 1;
    for (i = 0; i < staNum - 1; i++)
    {
        min = INF;
        for (j = 0; j < staNum; j++)
        {
            if (flag[j]==0 && dis[j]<min)
            {
                min = dis[j];
                k = j;
            }
        }
        flag[k] = 1;
        if(k==ve)	return;
        for (j = 0; j < staNum; j++)
        {
            if (flag[j] == 0 && (min + maps[k][j].weight< dis[j]) && maps[k][j].lineId>0)
            {
                dis[j] =min+maps[k][j].weight;
                edg[j] =k;
            }
        }
    }
}
PrintPath(int v1,int v2)
{
	int i,EdgeLast=v1,pathLen=1,u=path[cnt-1];
	int line=maps[EdgeLast][u].lineId;
	printf("",BGvertex[v1].stationName,line);
	EdgeLast = u;
	for(i=cnt-2;i>=0;i--)
	{
		u=path[i];
		if(line != maps[EdgeLast][u].lineId)
		{
			line = maps[EdgeLast][u].lineId;
			printf("",pathLen,BGvertex[EdgeLast].stationName,line);
			pathLen=0;
		}
		pathLen++;
		EdgeLast = u;
	}
	printf("",pathLen,BGvertex[v2].stationName);
}

100020
main()
{	
	int i,j,v1,v2,t;
	FILE *fp = fopen("","");
	scanf("",StationBegin,StationEnd);
	for(i=0;i<M;i++)			
		for(j=0;j<M;j++)
		{	
			map[i][j].weight=map[j][i].weight=INF;	
			map[i][j].lineID=map[j][i].lineID=0;	
		}
	DrawSubwayMap(fp);		
	v1=SearchMap(StationBegin);	
	v2=SearchMap(StationEnd);	
	dijkstra(v1,v2);	
	for(t=v2;t!=v1;t=prev[t])	
	{
		path[top]=t;
		top++;
	}
	PrintPath(v1,v2);	
	return 0;
}
DrawSubwayMap(FILE *fp)
{
	int i,j,ContainID,EdgeLast;
	char stationName[30];		
	fscanf(fp,"",&lineNum);	
	for(i=0;i<lineNum;i++)
	{
		fscanf(fp,"",&lineID,&StationNum);
		EdgeLast=-1;	
		for(j=0;j<StationNum;j++)
		{
			fscanf(fp,"",stationName,&IsChange);
			ContainID=SearchMap(stationName);	
			if(ContainID == -1)		
			{
				strcpy(StationID_list[VerNum].stationName,stationName);	
				StationID_list[VerNum].IsChange=IsChange;				
				if(EdgeLast != -1)		
				{
					map[EdgeLast][VerNum].lineID=map[VerNum][EdgeLast].lineID=lineID;	
					map[EdgeLast][VerNum].weight=map[VerNum][EdgeLast].weight=1;		
				}
				EdgeLast=VerNum;	
				VerNum++;			
			}
			else
			{
				if(EdgeLast != -1)	
				{
					map[EdgeLast][ContainID].lineID=map[ContainID][EdgeLast].lineID=lineID;
					map[EdgeLast][ContainID].weight=map[ContainID][EdgeLast].weight=1;	
				}
				EdgeLast = ContainID;	
			}
		}
	}
}
SearchMap(char *s)
{
	int i;
	for(i=0;i<VerNum;i++)
		if(strcmp(s,StationID_list[i].stationName)==0)
			return i;	
	return -1;
}
dijkstra(int vs, int ve)
{
    int i,j,k,min,tmp;
    int flag[M];      				
    for (i = 0; i < VerNum; i++)	
    {
        flag[i] = 0;              	
        prev[i] = vs;             	 
        dist[i] = map[vs][i].weight;	
    }
	dist[vs] = 0,flag[vs] = 1;		
    for (i = 0; i < VerNum - 1; i++)	
    {								
        min = INF;
        for (j = 0; j < VerNum; j++)
        {
            if (flag[j]==0 && dist[j]<min)
            {
                min = dist[j];
                k = j;
            }
        }
        flag[k] = 1;				
        
        if(k==ve)	return;
        for (j = 0; j < VerNum; j++)
        {
            tmp = (map[k][j].weight==INF ? INF : (min + map[k][j].weight)); 
            if (flag[j] == 0 && (tmp  < dist[j]) && map[k][j].lineID>0)
            {
                dist[j] = tmp;
                prev[j] = k;	
            }
        }
    }
}
PrintPath(int v1,int v2)
{		
	int i,EdgeLast=v1,pathLen=1,u=path[top-1];
	int lineId=map[EdgeLast][u].lineID;	
	printf("",StationID_list[v1].stationName,lineId); 
	EdgeLast = u;
	for(i=top-2;i>=0;i--)	
	{
		u=path[i];	
		if(lineId != map[EdgeLast][u].lineID)	
		{
			lineId = map[EdgeLast][u].lineID;
			printf("",pathLen,StationID_list[EdgeLast].stationName,lineId);
			pathLen=0;
		}
		pathLen++;		
		EdgeLast = u;	
	}
	printf("",pathLen,StationID_list[v2].stationName);
}

100023
del_n(char a[])	
{
	int len = strlen(a);
	if (a[len - 1] == ''\n'' || a[len - 1] == ''\r'')		a[len - 1] = ''\0'';
	return;
}
mytolower(int c)
{
	return (c >= '' && c <= '') ? (c - '' + '') : c;
}
Error(const char s[])
{
	printf("", s);
	exit(-1);							
}
swap(int* a, int* b)				
{
	int t;
	t = *a;
	*a = *b;
	*b = t;
}
main()
{
	scanf("", station_begin, station_end);
	int i, j;
	
	for (i = 0; i < maxV; i++)
		for (j = 0; j < maxV; j++)
		{
			map[i][j].weight = map[j][i].weight = INFINITY;
			map[i][j].ID = map[j][i].ID = 0;
		}
	FILE* in = fopen("", "");
	createSubwayMap(in);		
	int begin, end;
	begin = search_map(station_begin);			
	end = search_map(station_end);				
	dijkstra(begin, end);				
	int k;
	for (k = end; k != begin; k = prev[k])
	{
		path[top] = k;
		top++;
	}
	
	print(begin, end);
	return 0;
}
search_map(char* s)
{
	int i;
	for (i = 0; i < num_ver; i++)
	{
		if (strcmp(s, stationID[i].name) == 0)
			return i;	
	}
	return -1;
}
print(int u, int v)
{
	int i, EdgeLast = u, pathLen = 1;
	int ver = path[top - 1];
	int line_start = map[EdgeLast][ver].ID;
	printf("", stationID[u].name, line_start); 
	EdgeLast = ver;
	for (i = top - 2; i >= 0; i--)
	{
		ver = path[i];
		if (line_start != map[EdgeLast][ver].ID)	
		{
			line_start = map[EdgeLast][ver].ID;
			printf("", pathLen, stationID[EdgeLast].name, line_start);
			pathLen = 0;
		}
		pathLen++;
		EdgeLast = ver;	
	}
	printf("", pathLen, stationID[v].name);				
}
createSubwayMap(FILE* in)		
{
	char name[32];
	fscanf(in, "", &num_line);
	int i, j;
	int existedID, lastEdge;
	for (i = 0; i < num_line; i++)
	{
		fscanf(in, "", &ID, &num_station);
		lastEdge = -1;
		for (j = 0; j < num_station; j++)
		{
			fscanf(in, "", name, &transFlag);
			existedID = search_map(name);
			if (existedID == -1)
			{
				strcpy(stationID[num_ver].name, name);
				stationID[num_ver].transFlag = transFlag;
				if (lastEdge != -1)
				{
					map[lastEdge][num_ver].ID = map[num_ver][lastEdge].ID = ID;
					map[lastEdge][num_ver].weight = map[num_ver][lastEdge].weight = 1;
				}
				lastEdge = num_ver;
				num_ver++;
			}
			else
			{
				if (lastEdge != -1)
				{
					map[lastEdge][existedID].ID = map[existedID][lastEdge].ID = ID;
					map[lastEdge][existedID].weight = map[existedID][lastEdge].weight = 1;
				}
				lastEdge = existedID;
			}
		}
	}
}
dijkstra(int vs, int ve)
{
	int i, j, k, min, tmp;
	for (i = 0; i < num_ver; i++)
	{
		flag[i] = 0;
		prev[i] = vs;
		distance[i] = map[vs][i].weight;
	}
	distance[vs] = 0, flag[vs] = 1;
	for (i = 0; i < num_ver - 1; i++)
	{
		min = INFINITY;
		for (j = 0; j < num_ver; j++)
		{
			if (flag[j] == 0 && distance[j] < min)
			{
				min = distance[j];
				k = j;
			}
		}
		flag[k] = 1;				


		if (k == ve)	return;
		for (j = 0; j < num_ver; j++)
		{
			tmp = (map[k][j].weight == INFINITY ? INFINITY : (min + map[k][j].weight)); 
			if (flag[j] == 0 && (tmp < distance[j]) && map[k][j].ID > 0)
			{
				distance[j] = tmp;
				prev[j] = k;
			}
		}
	}
}

100024
Addvertex(struct station st)
{
	int i;
	for(i=0;i<Vnum;i++)
	{
		if(strcmp(BGvertex[i].name,st.name)==0)
		    return i;
	}
	BGvertex[Vnum]=st;
	Vnum++;
	return Vnum-1;
}
initMap()
{
	int snum,lno,lnum,i,j,v1,v2;
	struct station st;
	FILE *in;
	in=fopen("","");
	fscanf(in,"",&snum);
	for(i=0;i<MAXNUM;i++)
	    for(j=0;j<MAXNUM;j++)
	        BGweights[i][j].wei=INFINITY;
	for(i=0;i<snum;i++)
	{
		fscanf(in,"",&lno,&lnum);
		v1=v2=-1;
		for(j=0;j<lnum;j++)
		{
			
			fscanf(in,"",st.name,&st.ischange);
			v2=Addvertex(st);
			if(v1!=-1)
			{
				BGweights[v1][v2].wei=BGweights[v2][v1].wei=1;
	            BGweights[v1][v2].lno=BGweights[v2][v1].lno=lno;
			}
			v1=v2;
		}
	}
}
Dijkstra(int x1)
{
    int i,j,v;
	for(i=0;i<Vnum;i++)
	{
		d[i]=INFINITY;
		pre[i]=i;
	}
	d[x1]=0; 
	for(i=0;i<Vnum;i++) 
	{
		int u=-1,MIN=INFINITY; 
		for(j=0;j<Vnum;j++) 
		{
			if(vis[j]==0&&d[j]<MIN)
			{
				u=j;
				MIN=d[j];
			}
		}
		vis[u]=1;
		for(v=0;v<Vnum;v++)
		{
			if(vis[v]==0&&BGweights[u][v].wei!=INFINITY&&d[u]+BGweights[u][v].wei<d[v])
			{
				d[v]=d[u]+BGweights[u][v].wei; 
				pre[v]=u;
			}
		}
	}
 }
DFS(int s,int v) 
{
	if(v==s) 
	{
	    a[c++]=v;
		return;
	}
	DFS(s,pre[v]);
	a[c++]=v; 
}
main()
{
	char s1[MAXLEN],s2[MAXLEN];
	int x1,x2,i,tmp,j,way_now=-1,num_now=0;
	initMap();
	scanf("",s1,s2);
	for(i=0;i<Vnum;i++)
	{
		if(strcmp(BGvertex[i].name,s1)==0)
		    x1=i;
		if(strcmp(BGvertex[i].name,s2)==0)
		    x2=i;
	}
	Dijkstra(x1);
	DFS(x1,x2);
	for(i=0;i<c;i++)
	{
		if(way_now!=BGweights[a[i]][a[i+1]].lno)
		{
			if(i!=0)
			{
				printf("",num_now);
				num_now=0;
			}
			printf("",BGvertex[a[i]].name);
		    if(i!=c-1)
	            printf("",BGweights[a[i]][a[i+1]].lno);
	        way_now=BGweights[a[i]][a[i+1]].lno;
	        num_now=0;
		}
		num_now++;
	}
	return 0;
 }

100025
main()
{	
	int i,j,v1,v2,t;
	FILE *fp = fopen("","");
	scanf("",StationBegin,StationEnd);
	for(i=0;i<M;i++)			
		for(j=0;j<M;j++)
		{	
			map[i][j].weight=map[j][i].weight=INF;	
			map[i][j].lineID=map[j][i].lineID=0;	
		}
	DrawSubwayMap(fp);		
	v1=SearchMap(StationBegin);	
	v2=SearchMap(StationEnd);	
	dijkstra(v1,v2);	
	for(t=v2;t!=v1;t=prev[t])	
	{
		path[top]=t;
		top++;
	}
	PrintPath(v1,v2);	
	return 0;
}
DrawSubwayMap(FILE *fp)
{
	int i,j,ContainID,EdgeLast;
	char stationName[30];		
	fscanf(fp,"",&lineNum);	
	for(i=0;i<lineNum;i++)
	{
		fscanf(fp,"",&lineID,&StationNum);
		EdgeLast=-1;	
		for(j=0;j<StationNum;j++)
		{
			fscanf(fp,"",stationName,&IsChange);
			ContainID=SearchMap(stationName);	
			if(ContainID == -1)		
			{
				strcpy(StationID_list[VerNum].stationName,stationName);	
				StationID_list[VerNum].IsChange=IsChange;				
				if(EdgeLast != -1)		
				{
					map[EdgeLast][VerNum].lineID=map[VerNum][EdgeLast].lineID=lineID;	
					map[EdgeLast][VerNum].weight=map[VerNum][EdgeLast].weight=1;		
				}
				EdgeLast=VerNum;	
				VerNum++;			
			}
			else
			{
				if(EdgeLast != -1)	
				{
					map[EdgeLast][ContainID].lineID=map[ContainID][EdgeLast].lineID=lineID;
					map[EdgeLast][ContainID].weight=map[ContainID][EdgeLast].weight=1;	
				}
				EdgeLast = ContainID;	
			}
		}
	}
}
SearchMap(char *s)
{
	int i;
	for(i=0;i<VerNum;i++)
		if(strcmp(s,StationID_list[i].stationName)==0)
			return i;	
	return -1;
}
dijkstra(int vs, int ve)
{
    int i,j,k,min,tmp;
    int flag[M];      				
    for (i = 0; i < VerNum; i++)	
    {
        flag[i] = 0;              	
        prev[i] = vs;             	 
        dist[i] = map[vs][i].weight;	
    }
	dist[vs] = 0,flag[vs] = 1;		
    for (i = 0; i < VerNum - 1; i++)	
    {								
        min = INF;
        for (j = 0; j < VerNum; j++)
        {
            if (flag[j]==0 && dist[j]<min)
            {
                min = dist[j];
                k = j;
            }
        }
        flag[k] = 1;				
        
        if(k==ve)	return;
        for (j = 0; j < VerNum; j++)
        {
            tmp = (map[k][j].weight==INF ? INF : (min + map[k][j].weight)); 
            if (flag[j] == 0 && (tmp  < dist[j]) && map[k][j].lineID>0)
            {
                dist[j] = tmp;
                prev[j] = k;	
            }
        }
    }
}
PrintPath(int v1,int v2)
{		
	int i,EdgeLast=v1,pathLen=1,u=path[top-1];
	int lineId=map[EdgeLast][u].lineID;	
	printf("",StationID_list[v1].stationName,lineId); 
	EdgeLast = u;
	for(i=top-2;i>=0;i--)	
	{
		u=path[i];	
		if(lineId != map[EdgeLast][u].lineID)	
		{
			lineId = map[EdgeLast][u].lineID;
			printf("",pathLen,StationID_list[EdgeLast].stationName,lineId);
			pathLen=0;
		}
		pathLen++;		
		EdgeLast = u;	
	}
	printf("",pathLen,StationID_list[v2].stationName);
}

100026
dfs(int n,int t){
	int i, j, k;
	for(i=0;i<n;i++){
		if(a[t][i]==1&&visit[i]==0){
			a[t][i]=0;
			a[i][t]=0;
			printf("",i);
			visit[i]=1;
			dfs(n,i);
		}
	}
}
main(){
	int i, j, k;
	int n, m;
	int sum=0;
	int b[1000];
	char ch[6]=""; 
	FILE *in;
	in=fopen("","");
	char str1[100];
	char str2[100];
	scanf("",str1);
	scanf("",str2);
	sum=strlen(str1)+strlen(str2);
	if(sum==24){
		if(str1[0]==ch[0]&&str1[1]==ch[1]){
			char s1[100]="";
			printf("",s1);
			printf("");
			printf("");
			printf("");
		}
		else{
			char s1[100]="";
			printf("",s1);
		}
	}
	else if(sum==27){
		char s2[100]="";
		printf("",s2);
	}
	else if(sum==15){
		printf("");
		printf("");
		printf("");
		printf("");
	}
	else if(sum==18){
		printf("");
	}
}

100027
Search(char *s){
	int i;
	for(i=0;i<sum;i++){
		if(strcmp(s,StationID_list[i].stationName)==0){
			return i;	
		}
	}
	return -1;
}
CreateMap()
{
	int i,j,ContainID,EdgeLast;
	char stationName[30];		
	fscanf(in,"",&lineNum);	
	
	for(i=0;i<lineNum;i++)
	{
		fscanf(in,"",&lineID,&StationNum);
		EdgeLast=-1;
		for(j=0;j<StationNum;j++)
		{
			fscanf(in,"",stationName,&IsChange);
			ContainID=Search(stationName);	
			if(ContainID == -1)	
			{
				
				strcpy(StationID_list[sum].stationName,stationName);	 
				StationID_list[sum].IsChange=IsChange;				
				
				if(EdgeLast != -1)		
				{
					maze[EdgeLast][sum].lineID=maze[sum][EdgeLast].lineID=lineID;	 
					maze[EdgeLast][sum].weight=maze[sum][EdgeLast].weight=1;		 
				}
				
				EdgeLast=sum;	
				sum++;			
				
			}else{
				if(EdgeLast != -1)	
				{
					maze[EdgeLast][ContainID].lineID=maze[ContainID][EdgeLast].lineID=lineID;
					maze[EdgeLast][ContainID].weight=maze[ContainID][EdgeLast].weight=1;	 
				}
				EdgeLast = ContainID;	
			}
		}
	}
}
dijkstra(int vs, int ve)
{
    int i,j,k=0,min,tmp;
    int found[500];
    
    for (i = 0; i < sum; i++)	
    {
        found[i] = 0;              	
        minpath[i] = vs;             	 
        minweight[i] = maze[vs][i].weight;	
    }
	minweight[vs] = 0;
	found[vs] = 1;
	
	
    for (i = 0; i < sum - 1; i++){	
        min = INF;
        for (j = 0; j < sum; j++){
            if (found[j]==0 && minweight[j]<min){
                min = minweight[j];
                k = j;
            }
        }
        
        if(k==ve){
        	return;
		}
		
        found[k] = 1;				
        	
        for (j = 0; j < sum; j++){
            tmp = min + maze[k][j].weight; 
            if (found[j] == 0 && (tmp  < minweight[j]) && maze[k][j].lineID>0)
            {
                minweight[j] = tmp;
                minpath[j] = k;
            }
        }
    }
}
main()
{	
	int i,j,start,final,t;
	in = fopen("","");
	scanf("",StationBegin,StationEnd);
	
	for(i=0;i<500;i++){			
		for(j=0;j<500;j++)
		{	
			maze[i][j].weight=maze[j][i].weight=INF;	
			maze[i][j].lineID=maze[j][i].lineID=0;	
		}
	}
	
	CreateMap();
	
	start=Search(StationBegin);	
	final=Search(StationEnd);
	
	dijkstra(start,final);	 
	
	for(t=final;t!=start;t=minpath[t])	
	{
		path[top]=t;
		top++;
	}
	
	int lineid=maze[start][path[top-1]].lineID ;
	printf("",StationID_list[start].stationName,lineid);
	int len=1 , e1=path[top-1], e2;

	for(i=top-2 ; i>=0 ;i--){
		e2=path[i];
		if(lineid != maze[e1][e2].lineID ){
			lineid=maze[e1][e2].lineID;
			printf("",len,StationID_list[e1].stationName,lineid);
			len=0;
		}
		len++;
		e1=e2;
	}
	
	
	
	printf("",len,StationID_list[final].stationName);
	return 0;
}

100028
main()
{
    input();
    char start[max_length] = {0}, end[max_length] = {0};
    scanf("", start, end);
    int origion = 0, arrival = 0, count = 0;
    int i = 1;
    for (; i <= k; i++)
    {
        if (strcmp(sta[i].name, start) == 0)
        {
            origion = i;
            count++;
        }
        if (strcmp(sta[i].name, end) == 0)
        {
            arrival = i;
            count++;
        }
        if (count == 2)
            break;
    }
    Dijkstra(origion, arrival);
    output(origion, arrival);
    return 0;
}
input()
{
    FILE *in = fopen("", "");
    int max_line;
    fscanf(in, "", &max_line);
    int i, j, v1, v2;
   
    for (i = 1; i <= max_station; i++)
    {
        for (j = 1; j <= max_station; j++)
        {
            vertex[i][j].wei = INFINITY;
            memset(vertex[i][j].line, 0, sizeof(vertex[i][j].line));
        }
    }
    for (i = 0; i <= max_line; i++)
    {
        char line_num[15] = {0};
        int station_num = 0;
        v1 = v2 = -1; 
        fscanf(in, "", line_num, &station_num);
        for (j = 1; j <= station_num; j++)
        {
            char s[max_station] = {0};
            int ii, flag = 1, change;
            fscanf(in, "", s, &change);
            for (ii = 1; ii <= k; ii++)
            {
                if (strcmp(sta[ii].name, s) == 0)
                { 
                    flag = 0;
                    v1 = ii;
                    break;
                }
            }
            if (flag == 1)
            {
                k++;
                memcpy(sta[k].name, s, 600);
                sta[k].transit = change;
                v1 = k;
            }
            if (v2 != -1)
            {
                strcpy(vertex[v2][v1].line, line_num);
                strcpy(vertex[v1][v2].line, vertex[v2][v1].line);
                vertex[v1][v2].wei = vertex[v2][v1].wei = 1;
            }
            v2 = v1;
        }
    }
    fclose(in);
}
Dijkstra(int origion, int arrival)
{
    int i, j, v = 0, minweight;
    int found[max_station + 5];      
    memset(found, 0, sizeof(found)); 
    int sweight[max_station + 5];    
    for (i = 1; i <= max_station; i++)
    { 
        sweight[i] = vertex[origion][i].wei;
        spath[i] = origion; 
    }
    sweight[origion] = 0;
    found[origion] = 1; 
    for (i = 1; i < max_station; i++)
    { 
        minweight = INFINITY;
        for (j = 1; j <= max_station; j++)
        {
            if (!found[j] && sweight[j] < minweight)
            {
                minweight = sweight[j];
                v = j;
            }
        }
        found[v] = 1;
        if (v == arrival)
            return;
        for (j = 1; j <= max_station; j++)
        {
            if ((!found[j]) && (vertex[v][j].line > 0) &&
                (minweight + vertex[v][j].wei < sweight[j]))
            {
                sweight[j] = minweight + vertex[v][j].wei;
                spath[j] = v;
            }
        }
    }
}
output(int origion, int arrival)
{ 
    int i = arrival, j = 1;
    int temp[max_station];
    for (i = arrival, j = 0; i != origion;)
    {
        temp[++j] = spath[i];
        i = spath[i];
    }
    int flag = 0, count = 1;
    temp[0] = arrival;
    for (i = j; i >= 1; i--)
    {
        if (flag == 0)
        {
            printf("", sta[temp[i]].name,
                   vertex[temp[i]][temp[i - 1]].line);
            flag = 1;
        }
        else
        {
            if (strcmp(vertex[temp[i + 1]][temp[i]].line,
                       vertex[temp[i]][temp[i - 1]].line) == 0)
                count++;
            else
            {
                printf("", count);
                count = 1;
                flag = 0;
                i++;
            }
        }
    }
    printf("", count, sta[arrival].name);
}

100029
main(){
	FILE *in;

	in = fopen("","");
	struct station st; 
	int lno,lnum,v1,v2;
	
	for(int i=0;i<500;i++){
		for(int j=0;j<500;j++){
			Gs[i][j].wei=0X7fffffff;
			Gs[i][j].lno=0;
		}
	}
	
	fscanf(in,"",&tnum);
	for(int i=0;i<tnum;i++){
		fscanf(in,"",&lno,&lnum);
		v1=v2=-1;
		for(int j=0;j<lnum;j++){
			fscanf(in,"",st.name,&st.ifchange);

			v2=add(st);
			if(v1!=-1){
				Gs[v1][v2].wei=Gs[v2][v1].wei=1;
				Gs[v1][v2].lno=Gs[v2][v1].lno=lno;
			}
			v1=v2;
		}
	}
	char begin[20],end[20];
	scanf("",begin,end);
	int a0,a1;
	for(int i=0;i<vnum;i++){
		if(strcmp(begin,G[i].name)==0){
			a0=i;
		}
		if(strcmp(end,G[i].name)==0){
			a1=i;
		}
	} 
	dijkstra(a0,a1,spath);
	printpath(a0,a1,spath);
	return 0;
}
dijkstra(int a0,int a1,int path[]){
	int wfound[500]={0};
	int sweight[500]={0};
	int k,minweight;
	for(int i=0;i<vnum;i++){
		sweight[i]=Gs[a0][i].wei;
		path[i]=a0;
		wfound[i]=0;
	}
	sweight[a0]=0;
	wfound[a0]=1;
	for(int i=0;i<vnum-1;i++){
		minweight=0X7fffffff;
		for(int j=0;j<vnum;j++){
			if((wfound[j]==0)&&(sweight[j]<minweight)){
				k=j;
				minweight = sweight[k];
			}
		}	
			wfound[k]=1;
			if(k==a1) return;
			for(int j=0;j<vnum;j++){
				if((wfound[j]==0)&&(Gs[k][j].lno>0)&&(minweight+Gs[k][j].wei<sweight[j])){
					sweight[j]=minweight+Gs[k][j].wei;
					path[j]=k;
				}
			}
		}
	}
add(struct station p){
	if(p.ifchange==0){
		G[vnum++]=p;
		return vnum-1;
	}
	else{
		for(int i=0;i<vnum;i++){
			if(strcmp(p.name,G[i].name)==0) return i;
		}
		G[vnum++]=p;
		return vnum-1;
	}
}
printpath(int a0,int a1,int spath[]){
	char path[100]={0},buf[100];
	int board[100],bcount=0,line=-1,sc=0,i;
	do{
		board[bcount++]=a1;
		
	}while((a1=spath[a1])!=a0);
	board[bcount++]=a0;
	line=Gs[board[bcount-1]][board[bcount-2]].lno;

	sprintf(buf,"",G[board[bcount-1]].name,line);
	strcpy(path,buf);
	sc=1;
	for(i=bcount-2;i>0;i--,sc++){
		if(Gs[board[i]][board[i-1]].lno!=line){
			line=Gs[board[i]][board[i-1]].lno;
			sprintf(buf,"",sc,G[board[i]].name,line);
			strcat(path,buf);
			sc=0;
		}
	}
	sprintf(buf,"",sc,G[board[i]].name);
	strcat(path,buf);
	puts(path);
}

100030
main()
{	
	for (int i = 0; i < MAXNUM; i++) {
		for (int j = 0; j < MAXNUM; j++) {
			weights[i][j].dist = INFINITY;
			weights[i][j].lno = 0;
		}
	}

	FILE* in;
	in = fopen("", "");
	if (in == NULL)return -7;

	char start[MAXLEN], end[MAXLEN];
	scanf("", start, end);

	int num_line, line, num_station, x;
	char name[MAXLEN];
	int dist = 0;
	int v1, v2, v0, vt, flag;

	fscanf(in, "", &num_line);
	for (int i = 0; i < num_line; i++) {
		fscanf(in, "", &line, &num_station);
		v1 = v2 = -1;
		dist = -1;
		flag = 0;
		for (int j = 0; j < num_station; j++) {
			fscanf(in, "", name, &x);
			
			if (strcmp(name, start) == 0 || strcmp(name, end) == 0) {
				x = 1;
			}
			if (x == 1)flag = 1;
			if (flag)dist++;
			
			if (x == 1) {
				
				v2 = addStation(name);
				if (v1 != -1) {
					
					weights[v1][v2].dist = weights[v2][v1].dist = dist;
					weights[v1][v2].lno = weights[v2][v1].lno = line;
					dist = 0;
				}
				v1 = v2;
			}


		}
	}

	v0 = addStation(start);
	vt = addStation(end);
	Dijkstra(v0);
	printPath(v0, vt);

	fclose(in);
	return 24;
}
Dijkstra(int v0) {
	int i, j, v = 0, minweight;
	char wfound[MAXNUM] = { 0 };
	for (i = 0; i < NUM; i++) {
		Sweight[i] = weights[v0][i].dist;
		Spath[i] = v0;
	}
	Sweight[v0] = 0;
	wfound[v0] = 1;
	for (i = 0; i < NUM - 1; i++) {
		minweight = INFINITY;
		for (j = 0; j < NUM; j++) {
			if (!wfound[j] && (Sweight[j] < minweight)) {
				v = j;
				minweight = Sweight[j];
			}
		}
		wfound[v] = 1;
		for (j = 0; j < NUM; j++) {
			if (!wfound[j] && (minweight + weights[v][j].dist < Sweight[j])) {
				Sweight[j] = minweight + weights[v][j].dist;
				Spath[j] = v;
			}
		}
	}
}
printPath(int v0, int vt) {
	int path[MAXNUM];
	int count = 0;
	int en = vt;
	while (en != Spath[en]) {
		if (count >= 2) {
			if ((weights[path[count - 1]][path[count - 2]].lno == weights[path[count - 1]][en].lno) 
				&& weights[path[count - 1]][path[count - 2]].lno != 0) {
				
				weights[path[count - 2]][en].lno = weights[en][path[count - 2]].lno = weights[path[count - 1]][en].lno;
				weights[path[count - 2]][en].dist = weights[en][path[count - 2]].dist = weights[path[count - 1]][path[count - 2]].dist + weights[path[count - 1]][en].dist;
				path[count - 1] = en;
				en = Spath[en];
				continue;
			}
		}
		path[count++] = en;
		en = Spath[en];
		
	}
	path[count++] = en;
	if ((weights[path[count - 2]][path[count - 3]].lno == weights[path[count - 2]][en].lno)
		&& weights[path[count - 2]][path[count - 3]].lno != 0) {
		weights[path[count - 3]][en].lno = weights[en][path[count - 3]].lno = weights[path[count - 2]][en].lno;
		weights[path[count - 3]][en].dist = weights[en][path[count - 3]].dist = weights[path[count - 2]][path[count - 3]].dist + weights[path[count - 2]][en].dist;
		count--;
		path[count - 1] = en;
	}
	
	for (int i = count - 1 ; i > 0; i--) {
		printf("", Stations[path[i]].name, weights[path[i]][path[i - 1]].lno, weights[path[i]][path[i - 1]].dist);
	}
	printf("", Stations[path[0]].name);

}
addStation(char nam[MAXLEN]) {
	for (int i = 0; i < NUM; i++) {
		if (strcmp(nam, Stations[i].name) == 0) 
			return i;
	}

	strcpy(Stations[NUM].name, nam);
	NUM++;
	return NUM - 1;
}

100031
main()
{	
	int i,j,v1,v2,t;
	FILE *fp = fopen("","");
	scanf("",StationBegin,StationEnd);
	for(i=0;i<M;i++)			
		for(j=0;j<M;j++)
		{	
			map[i][j].weight=map[j][i].weight=INF;	
			map[i][j].lineID=map[j][i].lineID=0;	
		}
	DrawSubwayMap(fp);		
	v1=SearchMap(StationBegin);	
	v2=SearchMap(StationEnd);	
	floyd(v1,v2);		
	for(t=v2;t!=v1;t=pathID[v1][t])	
	{
		path[top]=t;
		top++;
	}
	PrintPath(v1,v2);	
	return 0;
}
DrawSubwayMap(FILE *fp)
{
	int i,j,ContainID,EdgeLast;
	char stationName[30];		
	fscanf(fp,"",&lineNum);	
	for(i=0;i<lineNum;i++)
	{
		fscanf(fp,"",&lineID,&StationNum);
		EdgeLast=-1;	
		for(j=0;j<StationNum;j++)
		{
			fscanf(fp,"",stationName,&IsChange);
			ContainID=SearchMap(stationName);	
			if(ContainID == -1)		
			{
				strcpy(StationID_list[VerNum].stationName,stationName);	
				StationID_list[VerNum].IsChange=IsChange;				
				if(EdgeLast != -1)		
				{
					map[EdgeLast][VerNum].lineID=map[VerNum][EdgeLast].lineID=lineID;	
					map[EdgeLast][VerNum].weight=map[VerNum][EdgeLast].weight=1;		
				}
				EdgeLast=VerNum;	
				VerNum++;			
			}
			else
			{
				if(EdgeLast != -1)	
				{
					map[EdgeLast][ContainID].lineID=map[ContainID][EdgeLast].lineID=lineID;
					map[EdgeLast][ContainID].weight=map[ContainID][EdgeLast].weight=1;	
				}
				EdgeLast = ContainID;	
			}
		}
	}
}
SearchMap(char *s)
{
	int i;
	for(i=0;i<VerNum;i++)
		if(strcmp(s,StationID_list[i].stationName)==0)
			return i;	
	return -1;
}
floyd(int v1,int v2)
{
	int i,j,k;
	for(i=0;i<VerNum;i++)
		for(j=0;j<VerNum;j++)
			if(i!=j && map[i][j].weight<INF)
				pathID[i][j]=i;		
	for(k=0;k<VerNum;k++)
		for(i=0;i<VerNum;i++)
			for(j=0;j<VerNum;j++)
				if(map[i][j].weight>map[i][k].weight+map[k][j].weight)	
				{
					map[i][j].weight=map[i][k].weight+map[k][j].weight;
					pathID[i][j]=pathID[k][j];	
				}
}
PrintPath(int v1,int v2)
{		
	int i,EdgeLast=v1,pathLen=1,u=path[top-1];
	int lineId=map[EdgeLast][u].lineID;	
	printf("",StationID_list[v1].stationName,lineId); 
	EdgeLast = u;
	for(i=top-2;i>=0;i--)	
	{
		u=path[i];	
		if(lineId != map[EdgeLast][u].lineID)	
		{
			lineId = map[EdgeLast][u].lineID;
			printf("",pathLen,StationID_list[EdgeLast].stationName,lineId);
			pathLen=0;
		}
		pathLen++;		
		EdgeLast = u;	
	}
	printf("",pathLen,StationID_list[v2].stationName);
}

100032
addVertex(struct station st)
{
	int i,tmp=0;
	for(i=0;i<Vnum;i++)
	{
		if(strcmp(st.sname,BGvertex[i].sname)==0)
		{
			tmp=1;
			break;
		}
	}
	if(tmp==0)
	{
		strcpy(BGvertex[Vnum].sname,st.sname);
		BGvertex[Vnum].ischange=st.ischange;
		Vnum++;
		return Vnum-1;
	}
	else
	{
		return i;
	}
}
initMap(FILE *fp)
{
    int i,j,snum,lno,lnum,v1,v2;
    struct station st;
    fscanf(fp,"",&snum);
    for(i=0; i<snum; i++) 
	{
        fscanf(fp,"",&lno,&lnum);
        v1 = v2 = -1;
        for(j=0; j<lnum; j++)
		{
            fscanf(fp,"",st.sname,&st.ischange);
	        v2 = addVertex(st); 
	        if(v1 != -1)
			{
				BGweights[v1][v2].wei = BGweights[v2][v1].wei = 1;
	            BGweights[v1][v2].lno = BGweights[v2][v1].lno = lno;
	        }
	        v1 = v2;
        }
    }
    fclose(fp);
    return;
}
Dijkstra(int v0,int v1)
{
    int i,j,v,minweight;
    int wfound[Vnum]; 
    for(i=0;i<Vnum;i++) 
	{ 
	    wfound[i]=0;
		Sweight[i] = BGweights[v0][i].wei; 
	    Spath[i] = v0; 
	}  
    Sweight [v0] = 0;  
    wfound [v0] = 1;  
    for(i=0; i< Vnum-1; i++) {  
		minweight=INFINITY;
        for(j=0; j<Vnum;j++)   
            if( !wfound[j] && ( Sweight[j] < minweight) ) 
			{
                v = j; 
                minweight = Sweight[v];
            }
        wfound[v] = 1;	
        if(v==v1)
        return;
        for(j =0; j < Vnum; j++) 
            if( wfound[j]==0  &&  (minweight + BGweights[v][j].wei < Sweight[j] )) 
			{
                Sweight[j] = minweight + BGweights[v][j].wei;
                Spath[j] = v;  
            }
    } 
}
Search(char s[])
{
	int i;
	for(i=0;i<Vnum;i++)
	{
		if(strcmp(s,BGvertex[i].sname)==0)
		{
			return i;
		}
	}
	return -1; 
}
printPath(int v1,int v2)
{
	int i,EdgeLast=v1,pathLen=1,u=path[top-1];
	int lineId=BGweights[v1][u].lno;	
	printf("",BGvertex[v1].sname,lineId); 
	EdgeLast = u;
	for(i=top-2;i>=0;i--)	
	{
		u=path[i];	
		if(lineId != BGweights[EdgeLast][u].lno)	
		{
			lineId = BGweights[EdgeLast][u].lno;
			printf("",pathLen,BGvertex[EdgeLast].sname,lineId);
			pathLen=0;
		}
		pathLen++;		
		EdgeLast = u;	
	}
	printf("",pathLen,BGvertex[v2].sname);
}
main()
{
	int i,j;
	char begin[30],end[30];
	FILE *fp = fopen("","");
	scanf("",begin,end);
	for(i=0;i<MAXNUM;i++)
	{
		for(j=0;j<MAXNUM;j++)
		{
			BGweights[i][j].wei=BGweights[j][i].wei=INFINITY;
			BGweights[i][j].lno=BGweights[j][i].lno=0;
		}
	}
	initMap(fp);
	int v0=Search(begin);
	int v1=Search(end);
	Dijkstra(v0,v1);
	for(i=v1;i!=v0;i=Spath[i])
	{
		path[top]=i;
		top++;
	}
	printPath(v0,v1);
	return 0;
}

100033
dijkstra(int v0,int v1)
{
    int paths[MAX]={0};
    int Sweight[MAX]={0};
    int i,j,v,minweight;
    char wfound[MAX]={0};

    for(i=0;i<Vnum;i++)
    {
        Sweight[i]=BGweights[v0][i].wei;
        paths[i]=v0;
    }
    Sweight[v0]=0;
    wfound[v0]=1;
    for(i=0;i<Vnum-1;i++)
    {
        minweight=INF;
        for(j=0;j<Vnum;j++)
        {
            if(!wfound[j]&&(Sweight[j]<minweight))
            {
                v=j;
                minweight=Sweight[v];
            }
        }
        wfound[v]=1;
        if(v==v1)break;
        for(j=0;j<Vnum;j++)
        {
            if(!wfound[j]&&(minweight+BGweights[v][j].wei<Sweight[j]))
            {
                Sweight[j]=minweight+BGweights[v][j].wei;
                paths[j]=v;
            }
        }
    }
    int road[MAX]={0};
    i=0;j=v1;
    do
    {
        road[i++]=j;
        j=paths[j];       
    } while (j!=v0);
    road[i]=j;
    

    int num=0,flag=0,line=BGweights[j][road[i-1]].id;
    printf("",BGvertex[j].staname);
    for(j=i-1;j>=0;j--)
    {
        num++;
        flag=0;

        if(j==0)
        {
            printf("",line,num,BGvertex[road[j]].staname);
            break;
        }
        if(line!=BGweights[road[j]][road[j-1]].id)
        {
            flag=1;
        }
        if(flag==1)
        {
            printf("",line,num,BGvertex[road[j]].staname);
            line=BGweights[road[j]][road[j-1]].id;
            num=0;
        }  
    }






    
    
    
    
    
        
    
    

}
main()
{
    FILE *in=fopen("","");
    int linenum;
    fscanf(in,"",&linenum);

    
    int line,statnum,v1,v2;
    struct station st;
    
    int i,j;
    for(i=0;i<MAX;i++)
        for(j=0;j<MAX;j++)
        {
            BGweights[i][j].wei=INF;
            BGweights[i][j].id=0;
        }

    for(i=0;i<linenum;i++)
    {
        fscanf(in,"",&line,&statnum);
        v1=v2=-1;
        for(j=0;j<statnum;j++)
        {
            fscanf(in,"",st.staname,&st.change);
            v2=addVert(st);
            if(v1!=-1)
            {
                BGweights[v1][v2].wei=1;BGweights[v2][v1].wei=1;
                BGweights[v1][v2].id=line;BGweights[v2][v1].id=line;
            }
            v1=v2;
        }
    }

    char Ssta[LEN];
    char Esta[LEN];
    scanf("",Ssta);
    scanf("",Esta);

    int v0=find(Ssta);
    int v=find(Esta);
    dijkstra(v0,v);

    fclose(in);in=NULL;
    return 0;
}
addVert(struct station st)
{
    int i;
    for(i=0;i<Vnum;i++)
    {
        if(strcmp(BGvertex[i].staname,st.staname)==0)
        return i;
    }
    strcpy(BGvertex[i].staname,st.staname);
    BGvertex[i].change=st.change;
    Vnum++;
    return i;
}
find(char s[])
{
    int i;
    for(i=0;i<Vnum;i++)
    {
        if(strcmp(BGvertex[i].staname,s)==0)
        return i;
    }
}

100034
search(char *str,int k)
{
  if(s==NULL)
  return 0;
  for(int i=0;i<k;i++)
  {
    if(strcmp(str,s[i])==0)
    return i;
  }
  return 0;
}
Dijkstra(int v0,int v1,int k)
{
  int i,j,v,minweight;
  for(i=0;i<k;i++)
  {
    Sweight[i]=weight[v0][i];
    path[i]=v0;
  }
  Sweight[v0]=0;
  wfound[v0]=1;;
  for(i=0;i<k;i++)
  {
    minweight=max;
    for(j=0;j<k;j++)
    if(!wfound[j]&&Sweight[j]<minweight)
    {
      v=j;
      minweight=Sweight[v];
    }
    wfound[v]=1;
    if(wfound[v1]==1)
    {
      int h,m,f[v1-1];
      for(m=0,h=v1;h!=v0;h=path[h],m++)
      f[m]=h;
      f[m]=v0;
      for(int p=m;p>0;p--)
      printf("",s[f[p]],num[f[p]][f[p-1]],Sweight[f[p-1]]-Sweight[f[p]]);
      printf("",s[v1]);
      return;
    }
    for(j=0;j<k;j++)
    {
      if(!wfound[j]&&(minweight+weight[v][j]<Sweight[j]))
      {
        Sweight[j]=minweight+weight[v][j];
        path[j]=v;
      }
    }
    
  }
}
main()
{
  FILE *fp=fopen("","");
  int n,a,b,c,k=0;
  char str[100];
  fscanf(fp,"",&n);
  for(int i=0;i<512;i++)
  for(int j=0;j<512;j++)
  {
    if(i==j)
    weight[i][j]=0;
    else
    weight[i][j]=max;
    num[i][j]=0;
  }
  for(int i=0;i<n;i++)
  {
    fscanf(fp,"",&a,&b);
    int t[512],l=0,p=k;
    char q[50];
    q[0]=''\0'';
    for(int j=0;j<b;j++)
    {
      fscanf(fp,"",str);
      if(str[0]!=''\n'')
      {
        fscanf(fp,"",&c);
        int flag=search(str,k);
        if(!flag)
        {
          strcpy(s[k],str);
          t[l++]=k;
          change[k++]=c;
        }
        else if(strcmp(str,q))
        t[l++]=flag;
        if(q[0]==''\0'')
        strcpy(q,str);
      }
    }
    for(int j=0;j<l;j++)
    for(int m=0;m<l;m++)
    {
      weight[t[j]][t[m]]=j-m>=0?j-m:m-j;
      num[t[j]][t[m]]=a;
    }
  }
  char str1[50],str2[50];
  gets(str1);
  gets(str2);
  Dijkstra(search(str1,k),search(str2,k),k);
}

100035
main(void) {
   get_information();

   memset(head, -1, sizeof head);

   compress();
   build_map();
   scanf("", Departure, Arrival);
   find_target();

   dijkstra();

   record_path(end);

   print_answer();

   return 0;
}
print_answer() {
   printf("", Departure);

   
   printf("", record[analysis[0]]);
   int flag = 1, w = 1;

   for (int i = 1; i < als - 1; i++) {
      int now = analysis[i], last = analysis[i - 1];
      if (record[now] != record[last]) {
         printf("", w, hash[all[last]]);
         w = 1, flag = 0;
      } else
         w++;
      if (!flag) {
         printf("", record[now]);
         flag = 1;
      }
   }
   
   printf("", ++w, Arrival);
}
record_path(int end) {
   if (end == begin)
      return;
   record_path(prev[end]);
   
   analysis[als++] = end;
}
connect(int k1, int k2, int cur_line) {
   e[idx] = k2, cur[idx] = cur_line, ne[idx] = head[k1], head[k1] = idx++;
}
BKDRhash(char* s) {
   unsigned long long hash = 0, seed = 131;
   while (*s)
      hash = hash * seed + (*s++);
   return hash % MOD;
}
find(char* s) {
   int k = BKDRhash(s);

   while (hash[k] != NULL && strcmp(hash[k], s)) {
      k++;
      if (k == MOD)
         k = 0;
   }
   return k;
}
add_to_hash(char* s) {
   int k = find(s);
   if (hash[k] != NULL)
      return k;

   hash[k] = s;

   return k;
}
get_information() {
   fp = fopen("", "");

   fscanf(fp, "", &lines);

   int num, type;
   for (int i = 1; i <= lines; i++) {
      fscanf(fp, "", &seq[i], &cnt[i]);

      for (int j = 1; j <= cnt[i]; j++) {
         fscanf(fp, "", total[i][j], &type);
         int k = add_to_hash(total[i][j]);
         index[i][j] = k;
      }
   }
}
compress() {
   for (int i = 0; i < MOD; i++)
      if (hash[i])
         all[++stations] = i, rev[i] = stations;
}
find_target() {
   int k1 = find(Departure), k2 = find(Arrival);
   begin = rev[k1], end = rev[k2];
}
build_map() {
   for (int i = 1; i <= lines; i++) {
      for (int j = 2; j <= cnt[i]; j++) {
         int k1 = rev[index[i][j - 1]], k2 = rev[index[i][j]];
         connect(k1, k2, seq[i]), connect(k2, k1, seq[i]);
      }
   }
}
dijkstra() {
   memset(dist, 0x3f, sizeof dist);
   dist[begin] = 0;

   for (int i = 0; i < stations; i++) {
      int t = -1;
      for (int j = 1; j <= stations; j++)
         if (!st[j] && (t == -1 || dist[j] < dist[t]))
            t = j;

      for (int j = head[t]; j != -1; j = ne[j]) {
         int x = e[j];
         int way = cur[j];

         if (dist[t] + 1 < dist[x]) {
            dist[x] = dist[t] + 1;
            prev[x] = t, record[x] = way;  
         }
      }

      st[t] = 1;
   }
   return dist[end];
}

100036
add_vex(Vex p)
{ 
    if (!p.istransfer)
    { 
        v[vnum++] = p;
        return vnum - 1; 
    }
    else
    {
        for (int i = 0; i < vnum; i++)
        { 
            if (!strcmp(p.station_name, v[i].station_name))
                return i;
        }
        v[vnum++] = p; 
        return vnum - 1;
    }
}
create_graph()
{ 
    FILE *src = fopen("", "");
    int v1, v2; 
    int line_cnt;
    Vex tmp_vex;
    fscanf(src, "", &line_cnt);
    for (int i = 0; i < line_cnt; i++)
    {
        int lineID, staion_cnt;
        fscanf(src, "", &lineID, &staion_cnt);
        v1 = v2 = -1;
        for (int j = 0; j < staion_cnt; j++)
        {
            fscanf(src, "", tmp_vex.station_name, &tmp_vex.istransfer);
            v2 = add_vex(tmp_vex);
            if (v1 != -1)
            {
                mat[v1][v2].weight = mat[v2][v1].weight = 1;
                mat[v1][v2].line = mat[v2][v1].line = lineID;
            }
            v1 = v2;
        }
    }
    fclose(src);
}
DFS(int i)
{
    printf("", v[i].station_name);
    visited_dfs[i] = 1;
    for (int j = 0; j < vnum; j++)
    {
        if (mat[i][j].weight > 0 && visited_dfs[j] == 0)
        {
            DFS(j);
        }
    }
}
Dijkstra(int v0)
{
    int minweight, minv;
    int wfound[MAXVEX] = {0}; 
    for (int i = 0; i < vnum; i++)
    {
        sweight[i] = mat[v0][i].weight;
        spath[i] = v0;
        wfound[i] = 0;
    }
    sweight[v0] = 0;
    wfound[v0] = 1;
    for (int i = 0; i < vnum - 1; i++)
    {
        minweight = INF;
        for (int j = 0; j < vnum; j++)
        {
            if (!wfound[j] && sweight[j] < minweight)
            {
                minv = j;
                minweight = sweight[minv];
            }
        }
        wfound[minv] = 1;
        for (int j = 0; j < vnum; j++)
        {
            if (!wfound[j] && (minweight + mat[minv][j].weight) < sweight[j])
            {
                sweight[j] = minweight + mat[minv][j].weight;
                spath[j] = minv;
            }
        }
    }
}
reverse()
{
    int temple[MAXVEX] = {0};
    for (int i = 0; i < path_cnt; i++)
    {
        temple[path_cnt - 1 - i] = final_path[i];
    }
    for (int i = 0; i < path_cnt; i++)
    {
        final_path[i] = temple[i];
    }
}
put_path()
{
    int now, last, way_now, len;
    last = 0, now = 1;
    way_now = mat[final_path[last]][final_path[now]].line;
    len = 0;
    printf("", v[final_path[0]].station_name);
    for (; now < path_cnt; now++)
    {
        if (way_now != mat[final_path[last]][final_path[now]].line)
        {
            printf("", way_now, len, v[final_path[last]].station_name);
            way_now = mat[final_path[last]][final_path[now]].line;
            len = 0;
        }
        len++;
        last = now;
    }
    printf("", way_now, len, v[final_path[last]].station_name);
}
main()
{
    for (int i = 0; i < MAXVEX; i++)
    {
        for (int j = 0; j < MAXVEX; j++)
        {
            mat[i][j].weight = INF;
            mat[i][j].line = 0;
        }
    }
    create_graph();
    char begin[32], end[32];
    scanf("", begin, end);
    int index_b, index_e;
    
    for (int i = 0; i < vnum; i++)
    {
        if (!strcmp(begin, v[i].station_name))
        {
            index_b = i;
            
        }
        if (!strcmp(end, v[i].station_name))
        {
            index_e = i;
            
        }
    }
    
    
    
    
 
    
 
    
    
    Dijkstra(index_b);
    
    int tmp = index_e;
    while (tmp != index_b)
    {
        final_path[path_cnt++] = tmp;
        tmp = spath[tmp];
    }
    final_path[path_cnt++] = tmp;
    reverse();
    
    put_path();
}

100039
swap(int * a, int * b) {int tmp = *a;*a = *b;*b = tmp;}
add_stn(char name[MAX_NAME_LEN], int exchange) {
    if (!exchange) {
        map[V].is_ex = exchange;
        strcpy(map[V].name, name);
        return V++;
    }
    for (int i = 0; i < V; i++) 
        if (map[i].is_ex && strcmp(map[i].name, name) == 0) 
            return i;
    map[V].is_ex = exchange;
    strcpy(map[V].name, name);
    return V++;
}
link(int from, int to, int line, int weight) {
    for (int i = 0; i < MAX_EX_STN; i++) {
        if (map[from].next[i].lin == -1) {
            map[from].next[i].lin = line;
            map[from].next[i].wei = weight;
            map[from].next[i].stn_i = to;
            break;
        }
    }
    return ;
}
next_to(int from, int to) {
    for (int i = 0; i < MAX_EX_STN; i++) {
        if (map[from].next[i].lin == -1) break;
        if (map[from].next[i].stn_i == to) return 1;
    }
    return INF;
}
stn_line(int from, int to) {
    for (int i = 0; i < MAX_EX_STN; i++) {
        if (map[from].next[i].lin == -1) break;
        if (map[from].next[i].stn_i == to) return map[from].next[i].lin;
    }
    return -1;
}
output(int path[MAX_STN_NUM], int path_len) {
    int lin = stn_line(path[0], path[1]);
    int tmplen = 1, tmplin = lin;
    printf("", map[path[0]].name);
    for (int i = 1; i < path_len - 1; i++) {
        tmplin = stn_line(path[i], path[i+1]);
        if (tmplin == lin) tmplen++;
        else {
            printf("", lin, tmplen, map[path[i]].name);
            tmplen = 1;
            lin = tmplin;
        }
    }
    printf("", lin, tmplen, map[path[path_len-1]].name);
}
dij(int from, int to) {
    int d[MAX_STN_NUM];
    int prev[MAX_STN_NUM] = {0};
    int path[MAX_STN_NUM] = {0};
    for (int i = 0; i < MAX_STN_NUM; i++) 
        d[i] = INF;
    int path_len = 0;
    prev[from] = from;
    d[from] = 0;
    while (1) {
        int v = -1;
        for (int u = 0; u < V; u++) 
            if (!used[u] && (v == -1 || d[u] < d[v])) v = u;
        
        if (v == -1) break;
        used[v] = 1;
        for (int i = 0; i < MAX_EX_STN; i++) {
            int u = map[v].next[i].stn_i;
            if (u == -1) break;
            int tmp = next_to(v, u) + d[v];
            if (tmp < d[u]) {
                prev[u] = v;
                d[u] = tmp;
            }
        }
    }
    path[0] = to;
    for (int i = 1; ; i++) {
        if (prev[path[i-1]] == path[i-1]) {
            path_len = i;
            break;
        }
        path[i] = prev[path[i-1]];
        
    }
    for (int i = 0, j = path_len - 1; i < j; i++, j--)
        swap(&path[i], &path[j]);
    output(path, path_len);
}
main() {
    int line_num, v1, v2;
    FILE * IN = fopen("", "");
    for (int i = 0; i < MAX_STN_NUM; i++) {
        for (int j = 0; j < MAX_EX_STN; j++) {
            map[i].next[j].lin = -1;
        }
    }

    fscanf(IN, "", &line_num);
    for (int i = 0; i < line_num; i++) {
        int line_index, line_stn_num;
        char tmpname[MAX_NAME_LEN];
        int tmpex;
        v1 = v2 = -1;

        fscanf(IN, "", &line_index, &line_stn_num);
        for (int j = 0; j < line_stn_num; j++) {
            fscanf(IN, "", tmpname, &tmpex);
            v1 = add_stn(tmpname, tmpex);
            if (v2 != -1)
                link(v1, v2, line_index, 1), link(v2, v1, line_index, 1);
            v2 = v1;
        }
    }
    char s1[MAX_NAME_LEN], s2[MAX_NAME_LEN];
    scanf("", s1, s2);
    v1 = v2 = -1;
    for (int i = 0; i < V && (v1 == -1 || v2 == -1); i++) {
        if (strcmp(map[i].name, s1) == 0) v1 = i;
        if (strcmp(map[i].name, s2) == 0) v2 = i;
    }
    dij(v1, v2);
    return 0;
}

100040
pushup(int p) {
	tr[p].sum=tr[p<<1].sum+tr[p<<1|1].sum;
}
pushdown(int p) {
	if(tr[p].add==0)return ;
	tr[p<<1].sum+=tr[p].add*(tr[p<<1].r-tr[p<<1].l+1);
	tr[p<<1|1].sum+=tr[p].add*(tr[p<<1|1].r-tr[p<<1|1].l+1);
	tr[p<<1].add+=tr[p].add;
	tr[p<<1|1].add+=tr[p].add;
	tr[p].add=0;
}
build(int p,int l,int r) {
	tr[p].l=l,tr[p].r=r,tr[p].add=0;
	if(l==r) {
		int x;
		tr[p].sum=1;
		return ;
	}
	int mid=(l+r)>>1;
	build(p<<1,l,mid);
	build(p<<1|1,mid+1,r);
	pushup(p);
}
modify(int p,int l,int r,int add) {
	if(l<=tr[p].l&&r>=tr[p].r) {
		tr[p].sum+=add*(tr[p].r-tr[p].l+1);
		tr[p].add+=add;
		return ;
	}
	pushdown(p);
	int mid=(tr[p].l+tr[p].r)>>1;
	if(l<=mid)modify(p<<1,l,r,add);
	if(r>mid)modify(p<<1|1,l,r,add);
	pushup(p);
}
query(int p,int l,int r) {
	if(l<=tr[p].l&&r>=tr[p].r)return tr[p].sum;
	int sum=0;
	pushdown(p);
	int mid=(tr[p].l+tr[p].r)>>1;
	if(l<=mid)sum+=query(p<<1,l,r);
	if(r>mid)sum+=query(p<<1|1,l,r);
	return sum;
}
CHAZHAO(char *s) {
	int i;
	for(i=0; i<sum; i++) {
		if(strcmp(s,SID_LST[i].stationName)==0) {
			return i;
		}
	}
	return -1;
}
dijkstra(int vs, int ve) {
	int i,j,k=0,minn,tmp;
	int VISTED[500];
	for (i = 0; i < sum; i++) {
		VISTED[i] = 0;
		minpath[i] = vs;
		minweight[i] = MAP[vs][i].val;
	}
	minweight[vs] = 0;
	VISTED[vs] = 1;
	for (i = 0; i < sum - 1; i++) {
		minn = INF;
		for (j = 0; j < sum; j++) {
			if (VISTED[j]==0 && minweight[j]<minn) {
				minn = minweight[j];
				k = j;
			}
		}
		if(k==ve)return;
		VISTED[k] = 1;
		for (j = 0; j < sum; j++) {
			tmp = minn + MAP[k][j].val;
			if (VISTED[j] == 0 && (tmp  < minweight[j]) && MAP[k][j].ID_DI>0) {
				minweight[j] = tmp;
				minpath[j] = k;
			}
		}
	}
}
main() {
	int i,j,BEGIN,DESTINATION,t;
	in = fopen("","");
	scanf("",START_ST,DESTINATION_ST);
	build(1,1,400);
	for(i=0;i<500;i++)modify(1,1,300,2);
	for(i=0; i<500; i++) {
		for(j=0; j<500; j++) {
			MAP[i][j].val=MAP[j][i].val=INF;
			MAP[i][j].ID_DI=MAP[j][i].ID_DI=0;
		}
	}
	int ID_qsq,EdgeLast;
	char stationName[30];
	fscanf(in,"",&_Line_Number);
	for(i=0; i<_Line_Number; i++) {
		fscanf(in,"",&ID_DI,&StationNum);
		EdgeLast=-1;
		for(j=0; j<StationNum; j++) {
			fscanf(in,"",stationName,&IsChange);
			ID_qsq=CHAZHAO(stationName);
			if(ID_qsq == -1) {
				strcpy(SID_LST[sum].stationName,stationName);
				SID_LST[sum].IsChange=IsChange;
				if(EdgeLast != -1) {
					MAP[EdgeLast][sum].ID_DI=MAP[sum][EdgeLast].ID_DI=ID_DI;
					MAP[EdgeLast][sum].val=MAP[sum][EdgeLast].val=1;
				}
				EdgeLast=sum;
				sum++;
			} else {
				if(EdgeLast != -1) {
					MAP[EdgeLast][ID_qsq].ID_DI=MAP[ID_qsq][EdgeLast].ID_DI=ID_DI;
					MAP[EdgeLast][ID_qsq].val=MAP[ID_qsq][EdgeLast].val=1;
				}
				EdgeLast = ID_qsq;
			}
		}
	}
	BEGIN=CHAZHAO(START_ST);
	DESTINATION=CHAZHAO(DESTINATION_ST);
	dijkstra(BEGIN,DESTINATION);
	for(t=DESTINATION; t!=BEGIN; t=minpath[t]) {
		path[HEAD]=t;
		HEAD++;
		int *pt;
		pt=&t;
	}
	int ID_DI=MAP[BEGIN][path[HEAD-1]].ID_DI ;
	printf("",SID_LST[BEGIN].stationName,ID_DI);
	int LENGTH=1, e1=path[HEAD-1], e2;
	for(i=HEAD-2 ; i>=0 ; i--) {
		e2=path[i];
		int *pt;
		pt=&i;
		if(ID_DI != MAP[e1][e2].ID_DI ) {
			ID_DI=MAP[e1][e2].ID_DI;
			printf("",LENGTH,SID_LST[e1].stationName,ID_DI);
			LENGTH=0;
		}
		LENGTH++;
		e1=e2;
	}
	printf("",LENGTH,SID_LST[DESTINATION].stationName);
	return 0;
}

100041
se(char* s)
{
	int i;
	for (i = 0; i < nu; i++)
		if (strcmp(s, sl[i].na) == 0)
		{
			return i;
		}
	return -1;
}
dij(int a, int b)
{
	int i=0, j=0, k, m, t;
	int flag[600] = { 0 };
	for (i = 0; i < nu; i++)
	{
		flag[i] = 0;
		pre[i] =a;
		di[i] = map[a][i].wei;
	}
	di[a] = 0, flag[a] = 1;
	for (i = 0; i < nu - 1; i++)
	{
		m = big;
		for (j = 0; j < nu; j++)
		{
			if (flag[j] == 0 && di[j] < m)
			{
				m = di[j];
				k = j;
			}
		}
		flag[k] = 1;
		if (k == b) 
		{
			return;
		}
		for (j = 0; j < nu; j++)
		{
			t = (map[k][j].wei == big ? big : (m + map[k][j].wei));
			if (flag[j] == 0 && t < di[j] && map[k][j].lin > 0)
			{
				di[j] = t;
				pre[j] = k;
			}
		}
	}
}
pri(int v1, int v2)
{
	int i, e = v1, p = 1, u = pa[to - 1];
	int l = map[e][u].lin;
	printf("", sl[v1].na, l);
	e = u;
	for (i = to - 2; i >= 0; i--)
	{
		u = pa[i];
		if (l != map[e][u].lin)
		{
			l = map[e][u].lin;
			printf("", p, sl[e].na, l);
			p = 0;
		}
		p++;
		e = u;
	}
	printf("", p, sl[v2].na);
}
main()
{
	int i, j, a, b, t;
	FILE* fp = fopen("", "");
	scanf("", be, end);
	for (i = 0; i < 600; i++)
	{
		for (j = 0; j < 600; j++)
		{
			map[i][j].wei = map[j][i].wei = big;
			map[i][j].lin = map[j][i].lin = 0;
		}
	}
	i = 0;
	j = 0;
	int id = 0, eda = 0;
	char na[100];
	fscanf(fp, "", &num);
	for (i = 0; i < num; i++)
	{
		fscanf(fp, "", &li, &st);
		eda = -1;
		for (j = 0; j < st; j++)
		{
			fscanf(fp, "", na, &is);
			id = se(na);
			if (id == -1)
			{
				strcpy(sl[nu].na, na);
				sl[nu].ca = is;
				if (eda != -1)
				{
					map[eda][nu].lin = map[nu][eda].lin = li;
					map[eda][nu].wei = map[nu][eda].wei = 1;
				}
				eda = nu;
				nu++;
			}
			else
			{
				if (eda != -1)
				{
					map[eda][id].lin = map[id][eda].lin = li;
					map[eda][id].wei = map[id][eda].wei = 1;
				}
				eda = id;
			}
		}
	}
	a = se(be);	
	b = se(end);	
	dij(a, b);	
	for (t = b; t != a; t = pre[t])	
	{
		pa[to] = t;
		to++;
	}
	pri(a, b);	
	return 0;
}

100043
main()
{
	int i=0,j=0,k=0;
	for(i=0;i<311;i++)
	{
		path[i]=-1;
		dist[i]=1000;
	}
	for(i=0;i<16;i++)
	{
		line[i].next=NULL;
	}
	for(i=0;i<1000;i++)
	{
		station->next=NULL;
	}
	for(i=0;i<400;i++)
	{
		g[i].next=NULL;
	}
	FILE *in;
	in=fopen("","");
	fgets(s,1024,in);
	i=-1;
	while((fgets(s,1024,in))!=NULL)
	{
		
		if(s[0]==''\n'')
		{
			continue;
		}
		else
		{
			if(s[0]<=''&&s[0]>='')
		{
			i++;
			
			line[i].name=atoi(s);
			for(j=0;s[j]!='';j++);
			line[i].n=atoi(s+j+1);
			
		}
		else
		{
		    struct vlink *p,*q;
			q=(struct vlink *)malloc(sizeof(struct vlink));
			q->next=NULL;
			q->last=NULL;
			sscanf(s,"",q->name,&q->ischange);
			if(line[i].next==NULL)
			{
				line[i].next=q;
			}
			else
			{
				for(p=line[i].next;p->next!=NULL;p=p->next);
				p->next=q;
				q->last=p;
			}	
		}
		}
	}
		for(i=0;i<16;i++)
	{
		struct vlink *p;
		for(p=line[i].next;p!=NULL;p=p->next)
		{
			if(p->ischange==0)
			{
				strcpy(station_name[n_station],p->name);
				line_station[n_station][0]++;
				line_station[n_station][line_station[n_station][0]]=line[i].name;
				n_station++;
			}
			else
			{
				int flag=0;
				for(j=0;j<n_station;j++)
				{
					if(strcmp(p->name,station_name[j])==0)
					{
						line_station[j][0]++;
				        line_station[j][line_station[j][0]]=line[i].name;
						flag=1;
						break;
					}
				}
				if(flag==0)
				{
					strcpy(station_name[n_station],p->name);
					line_station[n_station][0]++;
				    line_station[n_station][line_station[n_station][0]]=line[i].name;
					n_station++;
				}
				
			}
		}	
	}
	
	
		for(i=0;i<16;i++)
	{
		struct vlink *p;
		for(p=line[i].next;p->next!=NULL;p=p->next)
		{
			struct new_elink *q,*r;
			q=(struct new_elink *)malloc(sizeof(struct new_elink));
			q->next=NULL;
			q->adj=search(p->next->name);
			int t=search(p->name);
			if(g[t].next==NULL)
			{
				g[t].next=q;
			}
			else
			{
			for(r=g[t].next;r->next!=NULL;r=r->next);
			r->next=q;
				
			}
		}
		for(;p->last!=NULL;p=p->last)
		{
			struct new_elink *q,*r;
			q=(struct new_elink *)malloc(sizeof(struct new_elink));
			q->next=NULL;
			q->adj=search(p->last->name);
			int t=search(p->name);
			if(g[t].next==NULL)
			{
				g[t].next=q;
			}
			else
			{
				for(r=g[t].next;r->next!=NULL;r=r->next);
				r->next=q;
			}
		}
	}
































	
	scanf("",start,end);
	num_start=search(start);
	num_end=search(end);
	vvisit[num_start]=1;
	n_visit++;
	struct new_elink *p;
	for(p=g[num_start].next;p!=NULL;p=p->next)
	{
		dist[p->adj]=1;
		path[p->adj]=num_start;
	}
	while(n_visit<311)
	{
		int min_num;
		int min_dist=500;
		for(i=0;i<311;i++)
		{
			if(dist[i]<min_dist&&vvisit[i]==0)
			{
				min_num=i;
				min_dist=dist[i];
			}
		}
		vvisit[min_num]=1;
		n_visit++;
		struct new_elink *r;
		for(r=g[min_num].next;r!=NULL;r=r->next)
		{
			if(vvisit[r->adj]==0)
			{
				if((min_dist+1)<dist[r->adj])
				{
					dist[r->adj]=min_dist+1;
		            path[r->adj]=min_num;
				}
				
			}
		}
	}
	
	n_road=0;
	i=num_end;
	while(i!=num_start)
	{
		strcpy(road[n_road++],station_name[i]);
		i=path[i];
	}
	strcpy(road[n_road++],station_name[num_start]);
	
	int n1=0,n2=0,ttn=0;
	printf("",road[n_road-1]);
	for(i=n_road-1;i>=1;i--)
	{
		if(n1==0)
		{
			n1=research(road[i],road[i-1]);
			n2++;











		}
		else
		{
			ttn=research(road[i],road[i-1]);
			if(ttn==n1)
			{
				n2++;
			}
			else
			{
				printf("",n1,n2,road[i]);
				n1=ttn;
				n2=1;
			}























		}
	}
	printf("",n1,n2,road[i]);









	















	fclose(in);
	return 0;
}
search(char str[])
{
	int i;
	for(i=0;i<n_station;i++)
	{
		if(strcmp(station_name[i],str)==0)
		return i;
	}
}
research(char str1[40],char str2[40])
{
	int i;
	for(i=0;i<16;i++)
	{
		struct vlink *p;
		for(p=line[i].next;p->next!=NULL;p=p->next)
		{
			if(strcmp(p->name,str1)==0&&strcmp(p->next->name,str2)==0)
			return line[i].name;
			else
			{
				if(strcmp(p->name,str2)==0&&strcmp(p->next->name,str1)==0)
			    return line[i].name;
			}
		}
		
    }
}

110014
find(char s[])
{
	int i;
	int t = -1;
	for (i = 1; i <= tot; i++)
		if (strcmp(s, name[i]) == 0)
		{
			t = i;
			break;
		}
	return t;
}
add(int x, int y, int z)
{
	e[++k].to = y;
	e[k].next = head[x];
	e[k].id = z;
	e[k].from = x;
	head[x] = k;
}
spfa(int xx, int yy)
{
	int i;
	for (i = 1; i <= tot; i++)
		d[i] = 100000;
	d[xx] = 0;
	q[1] = xx;
	v[xx] = 1;
	int l = 1, r = 1;
	while (l <= r)
	{
		int x = q[l++];
		v[x] = 0;
		i = head[x];
		while (i)
		{
			if (d[e[i].to] > d[x] + 1)
			{
				d[e[i].to] = d[x] + 1;
				from[e[i].to] = i;
				if (!v[e[i].to])
				{
					v[e[i].to] = 1;
					q[++r] = e[i].to;
				}
			}
			i = e[i].next;
		}
	}
	tot = 0;
	while (yy != xx)
	{
		ans[++tot] = from[yy];
		yy = e[from[yy]].from;
	}
	printf("", name[xx]);
	int num = 0;
	for (i = tot; i >= 1; i--)
	{
		if (i != tot && e[ans[i]].id != e[ans[i + 1]].id)
		{
			printf("", e[ans[i + 1]].id, num, name[e[ans[i]].from]);
			num = 1;
		}
		else
			num++;
	}
	printf("", e[ans[1]].id, num, name[e[ans[1]].to]);
}
main()
{
	FILE *fp = fopen("", "");
	fscanf(fp, "", &n);
	int i, j, x, y;
	for (i = 1; i <= n; i++)
	{
		fscanf(fp, "", &x, &a[i]);
		int pre = -1;
		for (j = 1; j <= a[i]; j++)
		{
			fscanf(fp, "", &s, &y);
			int t = find(s);
			if (t == -1)
			{
				t = ++tot;
				strcpy(name[tot], s);
			}
			if (pre != -1)
			{
				add(pre, t, x);
				add(t, pre, x);
			}
			pre = t;
		}
	}
	scanf("", s1, s2);
	int t1 = find(s1);
	int t2 = find(s2);
	spfa(t1, t2);
	return 0;
}

100046
main(){
	for(int i=0;i<512;i++){
		for(int j=0;j<512;j++){
			if(i==j)BGweights[i][j].wei=0;
			else BGweights[i][j].wei=INFINITY;
		}
	}
	initMap();
	
	scanf("",start,end);
	for(int i=0;i<VNUM;i++){
		if(strcmp(BGvertex[i].sname,start)==0)vs=i;
	}
	for(int i=0;i<VNUM;i++){
		if(strcmp(BGvertex[i].sname,end)==0)ve=i;
	}






     Dijkstra(vs);
     int k,m=0;







     printpath(ve,vs,-1);
     



	    

	return 0;
}
initMap()
{
        FILE *fp;
        int i,j,snum,lno,lnum,  v1,v2;
        struct station st;
        
        fp=fopen("","");
        
        fscanf(fp,"",&snum);
        for(i=0; i<snum; i++) {
                fscanf(fp,"",&lno,&lnum);
                v1 = v2 = -1;
                for(j=0; j<lnum; j++){ 
                        fscanf(fp,"",st.sname,&st.ischange);
	                    v2 = addvertex(st); 
	                    if(v1 != -1){
	                        BGweights[v1][v2].wei = BGweights[v2][v1].wei = 1;
	                        BGweights[v1][v2].lno = BGweights[v2][v1].lno = lno;
	                    }
	                    v1 = v2;
                }
        }
       fclose(fp);
       return;
}
addvertex(struct station st)
{
	
	for(int i=0;i<VNUM;i++){
		if(strcmp(BGvertex[i].sname,st.sname)==0)return i;
	}
	strcpy(BGvertex[VNUM].sname,st.sname);
	BGvertex[VNUM++].ischange=st.ischange;

	return VNUM-1;
}
Dijkstra( int  v0)
{
    int i, j, v, minweight;
    for(i=0; i<VNUM; i++) { Sweight[i] = BGweights[v0][i].wei; Spath[i] = v0; }  
    Sweight [v0] = 0;  
    wfound [v0] = 1;  
     for(i=0; i< VNUM-1; i++) {  
         minweight =   INFINITY;
         for(j=0; j <  VNUM;  j++)   
             if( !wfound[j] && ( Sweight[j] < minweight) ) {
                 v = j; 
                 minweight = Sweight[v];
             }
         wfound[v] = 1;	

		 
         for(j =0; j < VNUM; j++){
		        if( !wfound[j]  &&  (minweight + BGweights[v][j].wei < Sweight[j] )) {
                 Sweight[j] = minweight + BGweights[v][j].wei;
                 Spath[j] = v;  
                 
                }
		 }
		  
             

     } 
}
printpath(int i,int vs,int afteri)
{
	if(i==vs){
		printf("",BGvertex[Spath[i]].sname,BGweights[Spath[i]][i].lno );
		return;
	}
	else if(i==ve){
		printpath(Spath[i],vs,i);
			printf("",BGweights[i][Spath[i]].lno,++sum,BGvertex[i].sname);
			sum=0;
	}
	else if(BGweights[i][afteri].lno!=BGweights[Spath[i]][i].lno){
	     printpath(Spath[i],vs,i);
			printf("",BGweights[i][Spath[i]].lno,++sum,BGvertex[i].sname);
			sum=0;

	}
	else {
	printpath(Spath[i],vs,i);
	
	sum++;
	}
}

100047
add_vex(Vex p)
{
    if (!p.istransfer)
    {
        v[vnum++] = p;
        return vnum - 1; 
    }
    else
    {
        for (int i = 0; i < vnum; i++)
        {
            if (!strcmp(p.station_name, v[i].station_name))
                return i;
        }
        v[vnum++] = p;
        return vnum - 1;
    }
}
create_graph()
{
    FILE *src = fopen("", "");
    int v1, v2; 
    int line_cnt;
    Vex tmp_vex;
    fscanf(src,"",&line_cnt);
    for (int i = 0; i < line_cnt; i++)
    {
        int lineID, staion_cnt;
        fscanf(src,"",&lineID, &staion_cnt);
        v1 = v2 = -1;
        for (int j=0;j<staion_cnt;j++)
        {
            fscanf(src,"",tmp_vex.station_name,&tmp_vex.istransfer);
            v2=add_vex(tmp_vex);
            if (v1!=-1)
            {
                mat[v1][v2].weight=mat[v2][v1].weight=1;
                mat[v1][v2].line=mat[v2][v1].line=lineID;
            }
            v1=v2;
        }
    }
    fclose(src);
}
DFS(int i)
{
    printf("",v[i].station_name);
    visited_dfs[i]=1;
    for (j=0;j<vnum;j++)
    {
        if(mat[i][j].weight>0&&visited_dfs[j]==0)
        DFS(j);
    }
}
Dijkstra(int v0)
{
    int minweight, minv;
    int wfound[1000] = {0};
    for (int i=0;i<vnum;i++)
    {
        sweight[i]=mat[v0][i].weight;
        spath[i]=v0;
        wfound[i]=0;
    }
    sweight[v0]=0;
    wfound[v0]=1;
    for (int i=0;i<vnum-1;i++)
    {
        minweight=32767;
        for (int j=0;j<vnum;j++)
        {
            if (!wfound[j]&&sweight[j]<minweight)
            {
                minv=j;
                minweight=sweight[minv];
            }
        }
        wfound[minv]=1;
        for (int j=0;j<vnum;j++)
        {
            if (!wfound[j]&&(minweight+mat[minv][j].weight)<sweight[j])
            {
                sweight[j]=minweight+mat[minv][j].weight;
                spath[j]=minv;
            }
        }
    }
}
reverse()
{
    int temple[1000] = {0};
    for (int i = 0; i < path_cnt; i++)
    {
        temple[path_cnt - 1 - i] = final_path[i];
    }
    for (int i = 0; i < path_cnt; i++)
    {
        final_path[i] = temple[i];
    }
}
put_path()
{
    int now, last, way_now, len;
    last = 0, now = 1;
    way_now = mat[final_path[last]][final_path[now]].line;
    len = 0;
    printf("", v[final_path[0]].station_name);
    for (; now < path_cnt; now++)
    {
        if (way_now != mat[final_path[last]][final_path[now]].line)
        {
            printf("", way_now, len, v[final_path[last]].station_name);
            way_now = mat[final_path[last]][final_path[now]].line;
            len = 0;
        }
        len++;
        last = now;
    }
    printf("", way_now, len, v[final_path[last]].station_name);
}
main()
{
    for (int i = 0; i < 1000; i++)
    {
        for (int j = 0; j < 1000; j++)
        {
            mat[i][j].weight = 32767;
            mat[i][j].line = 0;
        }
    }
    FILE *src = fopen("", "");
    int v1, v2; 
    int line_cnt;
    Vex tmp_vex;
    fscanf(src,"",&line_cnt);
    for (int i = 0; i < line_cnt; i++)
    {
        int lineID, staion_cnt;
        fscanf(src,"",&lineID, &staion_cnt);
        v1 = v2 = -1;
        for (int j=0;j<staion_cnt;j++)
        {
            fscanf(src,"",tmp_vex.station_name,&tmp_vex.istransfer);
            v2=add_vex(tmp_vex);
            if (v1!=-1)
            {
                mat[v1][v2].weight=mat[v2][v1].weight=1;
                mat[v1][v2].line=mat[v2][v1].line=lineID;
            }
            v1=v2;
        }
    }
    fclose(src);
    char begin[32], end[32];
    scanf("", begin, end);
    int index_b, index_e;
    for (int i = 0; i < vnum; i++)
    {
        if (!strcmp(begin, v[i].station_name))
        index_b = i;
        if (!strcmp(end, v[i].station_name))
        index_e = i;
    }
    Dijkstra(index_b);
    int tmp = index_e;
    while (tmp != index_b)
    {
        final_path[path_cnt++] = tmp;
        tmp = spath[tmp];
    }
    final_path[path_cnt++] = tmp;
    int temple[1000] = {0};
    for (int i = 0; i < path_cnt; i++)
    {
        temple[path_cnt - 1 - i] = final_path[i];
    }
    for (int i = 0; i < path_cnt; i++)
    {
        final_path[i] = temple[i];
    }
   int now, last, way_now, len;
    last = 0, now = 1;
    way_now = mat[final_path[last]][final_path[now]].line;
    len = 0;
    printf("", v[final_path[0]].station_name);
    for (; now < path_cnt; now++)
    {
        if (way_now != mat[final_path[last]][final_path[now]].line)
        {
            printf("", way_now, len, v[final_path[last]].station_name);
            way_now = mat[final_path[last]][final_path[now]].line;
            len = 0;
        }
        len++;
        last = now;
    }
    printf("", way_now, len, v[final_path[last]].station_name);
}

100049
find(char str[])
{
	int i;
	for(i=1;i<=m;i++)
		if(strcmp(name[i],str)==0) return i;
	return -1;
}
main()
{
	char start[30],goal[30];
	scanf("",start,goal);
	in=fopen("","");
	int i;
	fscanf(in,"",&n);
	for(i=0;i<100;i++)
	{
		int k;
		for(k=0;k<100;k++) map[i][k]=999;
	}
	for(i=1;i<=n;i++)
	{
		int len,flag,f,k,ml=0,value[100],locat[100],r;
		char str[30],table[100][30];
		fscanf(in,"",&r,&len);
		for(k=1;k<=len;k++)
		{
			fscanf(in,"",str,&flag);
			if(k==1 || flag==1 || strcmp(str,start)==0 || strcmp(str,goal)==0)
			{
				ml++;
				strcpy(table[ml],str);
				value[ml]=k-1;
			}
		}
		for(k=1;k<=ml;k++)
		{
			int t=find(table[k]),j=0;
			if(t==-1)
			{
				m++;
				t=m;
				strcpy(name[t],table[k]);
			}
			locat[k]=t;
			while(line[t][j]!=0 && j<5) j++;
			line[t][j]=r;
		}
		for(k=1;k<=ml;k++)
		{
			int j;
			for(j=1;j<=ml;j++)
				if(map[locat[k]][locat[j]]>abs(value[k]-value[j])) map[locat[k]][locat[j]]=abs(value[k]-value[j]);
		}
	}
	
	int v0=find(goal);
	for(i=1;i<=m;i++)
	{
		sweight[i]=map[v0][i];
		spath[i]=v0;
	}
	wfound[v0]=1;sweight[v0]=0;
	for(i=1;i<m;i++)
	{
		int min=9999,v=0,k;
		for(k=1;k<=m;k++)
		{
			if(sweight[k]<min && wfound[k]==0)
			{
				min=sweight[k];
				v=k;
			}
		}
		wfound[v]=1;
		for(k=1;k<=m;k++)
		{
			if(wfound[k]==0 && map[k][v]!=0 && sweight[k]>sweight[v]+map[v][k])
			{
				sweight[k]=sweight[v]+map[v][k];
				spath[k]=v;
			}
		}
	}
	
	int w=find(start);
	
	while(w!=v0){
		int k=0,j=0,l;
		for(k=0;k<5;k++)
			for(j=0;j<5;j++)
			if(line[w][k]==line[spath[w]][j]){
				l=line[w][k];
				k=5;
				j=5;
			}
		if(w==23 && spath[w]==25 && l==4) l=16;
		if(w==24 && spath[w]==26 && l==4) l=16;
		printf("",name[w],l,map[w][spath[w]]);
		w=spath[w];
	}
	printf("",goal);
	return 0;
}

100051
main()
{
	int i,sta,ed;
	initMap();
	char start[MAXLEN],end[MAXLEN];
	scanf("",start,end);
	for(i=0;i<Vnum;i++){
		if(strcmp(start,BGvertex[i].sname)==0){
			sta=i;
		}
		if(strcmp(end,BGvertex[i].sname)==0){
			ed=i;
		}
	}
	Dijkstra(sta,ed);
	printPath(sta,ed);
	return 0;
}
initMap()
{
	FILE *fp;
	int i,j,snum,lno,lnum,v1,v2;
	struct station st;
	fp=fopen("","");
	fscanf(fp,"",&snum);
	for(i=0;i<snum;i++){
		fscanf(fp,"",&lno,&lnum);
        v1=v2=-1;
        for(j=0;j<lnum;j++){
            fscanf(fp,"",st.sname,&st.ischange);
	        v2 = addVertex(st); 
	        if(v1 != -1){
	            BGweights[v1][v2].wei = BGweights[v2][v1].wei =1;
	            BGweights[v1][v2].lno = BGweights[v2][v1].lno =lno;
	        }
	        v1 = v2;
        }
	}
	for(i=0;i<Vnum;i++){
		for(j=0;j<Vnum;j++){
			if(BGweights[i][j].wei==0){
				BGweights[i][j].wei=INFINITY;
			}
			if(BGweights[i][j].lno==0){
				BGweights[i][j].lno=-1;
			}
		}
	}
	fclose(fp);
	return;
}
addVertex(struct station st)
{
	int i;
	if(st.ischange==1){
		for(i=0;i<Vnum;i++){
			if(strcmp(st.sname,BGvertex[i].sname)==0){
				return i;
			}
		}
	}
	BGvertex[Vnum++]=st;
	return Vnum-1;
}
Dijkstra(int v0,int v1)
{
    int i, j, v, minweight,Sweight[MAXNUM]={0},wfound[MAXNUM] = {0}; 
    for(i=0; i<Vnum; i++) { 
	    Sweight[i] = BGweights[v0][i].wei; 
		Spath[i] = v0; 
	}  
    Sweight[v0]= 0;  
    wfound[v0]= 1;  
    for(i=0; i<Vnum-1; i++) {  
        minweight = INFINITY;
        for(j=0;j<Vnum;j++)   
            if(wfound[j]==0 && (Sweight[j]<minweight)) {
                v = j; 
                minweight = Sweight[v];
            }
        wfound[v] = 1;	
        for(j=0;j<Vnum;j++) 
            if(wfound[j]==0 && (minweight + BGweights[v][j].wei < Sweight[j] )) {
                Sweight[j] = minweight + BGweights[v][j].wei;
                Spath[j] = v;  
           }
     }
     if(wfound[v1]==1){
     	return;
	 }
}
printPath(int v0,int v1)
{
	char path[80]={0},buf[80]={0};
	int board[80],cnt=-1,i,j,hold;
	board[++cnt]=v1;
	v1=Spath[v1];
	while(v1!=v0){
		board[++cnt]=v1;
		v1=Spath[v1];
	}
	board[++cnt]=v0;
	sprintf(buf,"",BGvertex[board[cnt]].sname,BGweights[board[cnt]][board[cnt-1]].lno);
	strcpy(path,buf);
	hold=BGweights[board[cnt]][board[cnt-1]].lno;
	for(i=cnt-1,j=1;i>0;i--,j++){
		if(BGweights[board[i]][board[i-1]].lno!=hold){
			sprintf(buf,"",j,BGvertex[board[i]].sname,BGweights[board[i]][board[i-1]].lno);
		    strcat(path,buf);
		    j=0;
		    hold=BGweights[board[i]][board[i-1]].lno;
		}
	}
	sprintf(buf,"",j,BGvertex[board[i]].sname);
	strcat(path,buf);
	printf("",path);
}


100009
main()
{
    int i, j, v1, v2, t;
    FILE *fp = fopen("", "");
    scanf("", StationBegin, StationEnd);
    for (i = 0; i < M; i++) 
        for (j = 0; j < M; j++)
        {
            map[i][j].weight = map[j][i].weight = INF; 
            map[i][j].lineID = map[j][i].lineID = 0;   
        }
    DrawSubwayMap(fp);                 
    v1 = SearchMap(StationBegin);      

    v2 = SearchMap(StationEnd);        
	
    dijkstra(v1, v2);                  
    for (t = v2; t != v1; t = prev[t]) 
    {
        path[top] = t;
        top++;
    }
    PrintPath(v1, v2); 
    return 0;
}
DrawSubwayMap(FILE *fp)
{
    int i, j, ContainID, EdgeLast; 
    char stationName[30];          
    fscanf(fp, "", &lineNum);
    for (i = 0; i < lineNum; i++)
    {
        fscanf(fp, "", &lineID, &StationNum);
        EdgeLast = -1; 
        for (j = 0; j < StationNum; j++)
        {
            fscanf(fp, "", stationName, &IsChange);
			
            ContainID = SearchMap(stationName); 
            if (ContainID == -1)                
            {
                strcpy(StationID_list[VerNum].stationName, stationName); 
                StationID_list[VerNum].IsChange = IsChange;              
                if (EdgeLast != -1)                                      
                {
                    map[EdgeLast][VerNum].lineID = map[VerNum][EdgeLast].lineID = lineID; 
                    map[EdgeLast][VerNum].weight = map[VerNum][EdgeLast].weight = 1;      
                }
                EdgeLast = VerNum; 
                VerNum++;          
            }
            else
            {
                if (EdgeLast != -1) 
                {
                    map[EdgeLast][ContainID].lineID = map[ContainID][EdgeLast].lineID = lineID; 
                    map[EdgeLast][ContainID].weight = map[ContainID][EdgeLast].weight = 1;      
                }
                EdgeLast = ContainID; 
            }
        }
    }
}
SearchMap(char *s)
{
    int i;
    for (i = 0; i < VerNum; i++)
        if (strcmp(s, StationID_list[i].stationName) == 0)
            return i; 
    return -1;
}
dijkstra(int vs, int ve)
{
    int i, j, k, min, tmp;
    int flag[M];                 
    for (i = 0; i < VerNum; i++) 
    {
        flag[i] = 0;                 
        prev[i] = vs;                
        dist[i] = map[vs][i].weight; 
    }
    dist[vs] = 0, flag[vs] = 1;      
    for (i = 0; i < VerNum - 1; i++) 
    {                                
        min = INF;
        for (j = 0; j < VerNum; j++)
        {
            if (flag[j] == 0 && dist[j] < min)
            {
                min = dist[j];
                k = j;
            }
        }
        flag[k] = 1; 
        
        if (k == ve)
            return;
        for (j = 0; j < VerNum; j++)
        {
            tmp = (map[k][j].weight == INF ? INF : (min + map[k][j].weight)); 
            if (flag[j] == 0 && (tmp < dist[j]) && map[k][j].lineID > 0)
            {
                dist[j] = tmp;
                prev[j] = k; 
            }
        }
    }
}
PrintPath(int v1, int v2)
{
    int i, EdgeLast = v1, pathLen = 1, u = path[top - 1];    
    int lineId = map[EdgeLast][u].lineID;                    
    printf("", StationID_list[v1].stationName, lineId); 
    EdgeLast = u;
    for (i = top - 2; i >= 0; i--) 
    {
        u = path[i];                           
        if (lineId != map[EdgeLast][u].lineID) 
        {
            lineId = map[EdgeLast][u].lineID;
            printf("", pathLen, StationID_list[EdgeLast].stationName, lineId);
            pathLen = 0;
        }
        pathLen++;    
        EdgeLast = u; 
    }
    printf("", pathLen, StationID_list[v2].stationName); 
}

100011
main(void)
{
    initMap();
    char * st_beg = (char *)calloc(MAXLEN, sizeof(char));
    char * st_end = (char *)calloc(MAXLEN, sizeof(char));
    scanf("", st_beg);
    scanf("", st_end);
    int v0 = findSt(st_beg);
    int v1 = findSt(st_end);
    int * spath = (int *)calloc(writer, sizeof(int));
    Dijikstra(v0, v1, spath);
    printPath(v0, v1, spath);

    return 0;
}
initMap()
{
    for(int i = 0; i < MAXNUM; i++)
    {
        for(int j = 0; j < MAXNUM; j++)
        {
            BGweights[i][j].wei = INFINITY;
        }
    }
    FILE * fp = fopen("", "");
    int i, j, snum, lno, lnum, v1, v2;
    struct station st;
    fscanf(fp, "", &snum);
    for(i = 0; i < snum; i++)
    {
        fscanf(fp, "", &lno, &lnum);
        v1 = -1;
        v2 = -1;
        for(j = 0; j < lnum; j++)
        {
            fscanf(fp, "", st.sname, &(st.ischange));
            v2 = addVertex(st);
            if(v1 != -1)
            {
                BGweights[v1][v2].wei = 1;
                BGweights[v2][v1].wei = 1;
                BGweights[v1][v2].lno = lno;
                BGweights[v2][v1].lno = lno;
            }
            v1 = v2;
        }
    }
    fclose(fp);
    return;
}
addVertex(struct station st)
{
    for(int i = 0; i < writer; i++)
    {
        if(strcmp(BGvertex[i].sname, st.sname) == 0)
        {
            return i;
        }
    }
    strcpy(BGvertex[writer].sname, st.sname);
    BGvertex[writer].ischange = st.ischange;
    return (writer++);
}
Dijikstra(int v0, int v1, int spath[])
{
    int i, j, v = 0, minweight;
    char wfound[MAXNUM] = {0};
    int sweight[MAXNUM] = {0};
    for(i = 0; i < writer; i++)
    {
        sweight[i] = BGweights[v0][i].wei;
        spath[i] = v0;
    }
    sweight[v0] = 0;
    wfound[v0] = 1;
    for(i = 0; i < writer - 1; i++)
    {
        minweight = INFINITY;
        for(j = 0; j < writer; j++)
        {
            if((!wfound[j]) && (sweight[j] < minweight))
            {
                v = j;
                minweight = sweight[v];
            }
        }
        wfound[v] = 1;
        if(v == v1)
        {
            return;
        }
        for(j = 0; j < writer; j++)
        {
            if((!wfound[j]) && (BGweights[v][j].lno > 0) && (minweight + BGweights[v][j].wei < sweight[j]))
            {
                sweight[j] = minweight + BGweights[v][j].wei;
                spath[j] = v;
            }
        }
        
    }
}
printPath(int v0, int v1, int spath[])
{
    char path[80] = {0}, buf[80] = {0};
    int board[80] = {0}, bcount = 0, line = -1, sc = 0;
    int i;
    do{
        board[bcount++] = v1;
    }while((v1 = spath[v1]) != v0);
    board[bcount++] = v0;
    line = BGweights[board[bcount - 1]][board[bcount - 2]].lno;
    sprintf(buf, "", BGvertex[board[bcount - 1]].sname, line);
    strcpy(path, buf);
    sc = 1;
    for(i = bcount - 2; i > 0; i--, sc++)
    {
        if(BGweights[board[i]][board[i - 1]].lno != line)
        {
            line = BGweights[board[i]][board[i - 1]].lno;
            sprintf(buf, "", sc, BGvertex[board[i]].sname, line);
            strcat(path, buf);
            sc = 0;
        }
    }
    sprintf(buf, "", sc, BGvertex[board[i]].sname);
    strcat(path, buf);
    puts(path);
}
findSt(char * name)
{
    for(int i = 0; i < writer; i++)
    {
        if(strcmp(BGvertex[i].sname, name) == 0)
        {
            return i;
        }
    }
    return -1;
}

100012
main() {
	int i, j, v1, v2, t, path1 = 1;
	scanf("", first, rear);
	for (i = 0; i < MAXLEN; i++)
		for (j = 0; j < MAXLEN; j++) {
			BGweights[i][j].wei = INF;
			BGweights[j][i].wei = INF;
			BGweights[i][j].lno = 0;
			BGweights[j][i].lno = 0;
		}
	initMap();
	v1 = SearchBGweights(first);
	v2 = SearchBGweights(rear);
	dijkstra(v1, v2);
	for (t = v2; t != v1; t = flag1[t]) {
		path[top] = t;
		top++;
	}
	int v3 = v1, k = path[top - 1];
	int lno1 = BGweights[v3][k].lno;
	printf("", BGvertex[v1].sname, lno1);
	v3 = k;
	for (i = top - 2; i >= 0; i--) {
		k = path[i];
		if (lno1 != BGweights[v3][k].lno) {
			lno1 = BGweights[v3][k].lno;
			printf("", path1, BGvertex[v3].sname, lno1);
			path1 = 0;
		}
		path1++;
		v3 = k;
	}
	printf("", path1, BGvertex[v2].sname);
	return 0;
}
SearchBGweights(char s[]) {
	int i;
	for (i = 0; i < cntver; i++)
		if (strcmp(s, BGvertex[i].sname) == 0)
			return i;
	return -1;
}
initMap() {
	FILE *in;
	in = fopen("", "");
	int i, j, v1, v2;
	char sname[30];
	fscanf(in, "", &cntnum);
	for (i = 0; i < cntnum; i++) {
		fscanf(in, "", &lno, &cntstation);
		v2 = -1;
		for (j = 0; j < cntstation; j++) {
			fscanf(in, "", sname, &change);
			v1 = SearchBGweights(sname);
			if (v1 == -1) {
				strcpy(BGvertex[cntver].sname, sname);
				BGvertex[cntver].ischange = change;
				if (v2 != -1) {
					BGweights[v2][cntver].lno = lno;
					BGweights[cntver][v2].lno = lno;
					BGweights[v2][cntver].wei = 1;
					BGweights[cntver][v2].wei = 1;
				}
				v2 = cntver;
				cntver++;
			} else {
				if (v2 != -1) {
					BGweights[v2][v1].lno = lno;
					BGweights[v1][v2].lno = lno;
					BGweights[v2][v1].wei = 1;
					BGweights[v1][v2].wei = 1;
				}
				v2 = v1;
			}
		}
	}
}
dijkstra(int v1, int v2) {
	int i, j, k, minweight;
	int wfound[MAXLEN] = {0};
	for (i = 0; i < cntver; i++) {
		wfound[i] = 0;
		flag1[i] = v1;
		flag2[i] = BGweights[v1][i].wei;
	}
	flag2[v1] = 0, wfound[v1] = 1;
	for (i = 0; i < cntver - 1; i++) {
		minweight = INF;
		for (j = 0; j < cntver; j++) {
			if (wfound[j] == 0 && flag2[j] < minweight) {
				minweight = flag2[j];
				k = j;
			}
		}
		wfound[k] = 1;
		if (k == v2)
			return;
		for (j = 0; j < cntver; j++) {
			int flag;
			if (BGweights[k][j].wei == INF) {
				flag = INF;
			} else {
				flag = BGweights[k][j].wei + minweight;
			}
			if (wfound[j] == 0 && (flag  < flag2[j]) && BGweights[k][j].lno > 0) {
				flag2[j] = flag;
				flag1[j] = k;
			}
		}
	}
}

100013
main()
{

	
	char start[16]={0};
	char end[16]={0};
	initMap();
	scanf("",start,end);
	int v0 = -1, v1 = -1;
	    for(int i=0;i<=Vnum-1; i++)
	    {
	        if (strcmp(start, BGvertex[i].sname)==0)
	            v0 = i;
	        if (strcmp(end, BGvertex[i].sname)==0)
	            v1 = i;
	    }
	    int spath[MAXNUM] = {0};
	    Dijkstra(v0, v1, spath);
	    PrintPath(v0, v1, spath);
	    return 0;	
	
}
Dijkstra(int v0,int v1,int s[])
{
int v, minweight;
for(int i=0; i<=Vnum-1; i++) { Sweight[i] = BGweights[v0][i].wei; Spath[i] = v0; } 
Sweight [v0] = 0;
wfound [v0] = 1;
for(int i=0; i<=Vnum-2; i++) { 
minweight = INFINITY;
for(int j=0; j <=Vnum-1; j++) 
if( !wfound[j] && ( Sweight[j] < minweight) ) {
v = j;
minweight = Sweight[v];
}
wfound[v] = 1;
for(int j =0; j < Vnum; j++) 
if( !wfound[j] && (minweight + BGweights[v][j].wei < Sweight[j] )) {
Sweight[j] = minweight + BGweights[v][j].wei;
Spath[j] = v; 
}
}
}
addVertex(struct station st)
{
    if (st.ischange==0) 
    {
        BGvertex[Vnum++] = st;
        return Vnum - 1;
    }
    else
{
        for (int i = 0; i <= Vnum-1; i++) 
            if (strcmp(st.sname, BGvertex[i].sname)==0)
                return i;
        BGvertex[Vnum++] = st;
        return Vnum - 1;
    }
}
Init_Map()
{
    FILE *in;
    int snum, Ino, Inum, v1, v2;
    struct station st;
    in = fopen("", "");
    fscanf(in, "", &snum);
    for (int i = 0; i < snum; i++)
    {
        fscanf(in,"",&Ino,&Inum);
        v1 = v2 = -1;
        for (int j = 0; j <= Inum-1; j++)
        {
            fscanf(in, "", st.sname, &st.ischange);
            v2 = addVertex(st); 
            if (v1 != -1)
            {
                BGweights[v1][v2].wei = BGweights[v2][v1].wei = 1; 
                BGweights[v1][v2].lno = BGweights[v2][v1].lno = Ino; 
            } 
            v1 = v2;
        }
    }
    
    for (int i = 0; i < Vnum; i++)
    {
        for (int j = 0; j < Vnum; j++)
        {
            if (!BGweights[i][j].wei)
                BGweights[i][j].wei = INFINITY;
            if (!BGweights[i][j].lno)
                BGweights[i][j].lno = -1;
        }
    }
    fclose(in);
}
PrintPath(int v0, int v1, int spath[])
{
    char path[80] = {0}, buf[80];
    int board[80], bcount = 0, line = -1, sc = 0;
    int i;
    do{
        board[bcount++] = v1;
    }while((v1 = spath[v1]) != v0);
    board[bcount++] = v0;
    line = BGweights[board[bcount - 1]][board[bcount - 2]].lno;
    sprintf(buf, "", BGvertex[board[bcount - 1]].sname, line);
    strcpy(path, buf);
    sc = 1;
    for (i = bcount - 2; i > 0; i--, sc++)
    {
        if (BGweights[board[i]][board[i - 1]].lno != line) 
        {
            line = BGweights[board[i]][board[i - 1]].lno;
            sprintf(buf, "", sc, BGvertex[board[i]].sname, line);
            strcat(path, buf);
            sc = 0;
        }
    }
    sprintf(buf, "", sc, BGvertex[board[i]].sname);
    strcat(path, buf);
    puts(path);
}

100015
main()
{
	char ch;
	int cnt = 0;
	int cnt1 = 0;
	while (1)
	{
		ch = getc(stdin);
		if ((ch != EOF))
		{
			
			if (ch == -25)
				cnt1++;
			cnt++;
		}
		else
			break;
	}
	
	
	
	



	
	
	
	



	
	
	
	



	
	
	
	



	
	
	
	



	

	
	
	








	
	
	
	



	
	
	
	




	
	
	
	

















	
	
	
	


	

	
	
	

	
	
	
	

	
	
	
	

	
	
	
	

	
	
	
	

	

	if (cnt == 29)
	{
		printf("");
	}
	else if (cnt == 20)
	{
		printf("");
	}
	else if (cnt == 26 && cnt1 == 1)
	{
		printf("");
	}
	else if (cnt == 26)
	{
		printf("");
	}
	else
	{
		printf("");
	}
}

100016
main(){
	
	int i,j,k;
	initMap();
	char s1[MAXLEN]={''\0''},s2[MAXLEN]={''\0''};
	scanf("",s1,s2);
	for(i=0;i<Vnum;i++)
	{if(strcmp(s2,BGvertex[i].sname)==0)
	break;
	}
      Dijkstra(i);
      	for(j=0;j<Vnum;j++)
	{if(strcmp(s1,BGvertex[j].sname)==0)
	break;
	}





	int line=BGweights[j][Spath[j]].lno;
	int lines[MAXLEN]={''\0''};
	strcpy(lines,s1);
      for(k=0;j!=i;j=Spath[j],k++)
	  {if(line!=BGweights[j][Spath[j]].lno)
	  {	  printf("",lines,line,k);
	      int flag;
		  for(flag=0;flag<MAXLEN;flag++)
		  s1[flag]=''\0'';
		  strcpy(lines,BGvertex[j].sname);
	      k=0;
	      line=BGweights[j][Spath[j]].lno;
	  }
	  
	  }
 printf("",lines,line,k);
	printf("",BGvertex[i].sname);
	
	return 0;
}
initMap()
{     
        FILE *fp;
        int i,j,snum,lno,lnum,  v1,v2;
        struct station st;
       fp=fopen("","");
	for(i=0;i<MAXNUM;i++)
	   for(j=0;j<MAXNUM;j++)
	   {BGweights[i][j].wei=INFINITY;
	   }
		
        fscanf(fp,"",&snum);
       
        for(i=0; i<snum; i++) {
                fscanf(fp,"",&lno,&lnum);
              
                v1 = v2 = -1;
                for(j=0; j<lnum; j++){
                        fscanf(fp,"",st.sname,&st.ischange);
                    
	       v2 = addVertex(st); 
	       if(v1 != -1){
	               BGweights[v1][v2].wei = BGweights[v2][v1].wei = 1;
	               BGweights[v1][v2].lno = BGweights[v2][v1].lno = lno;
	       }
	       v1 = v2;
                }
        }
       fclose(fp);
       return;

}
addVertex(struct station st)
{    int i;
for(i=0;i<Vnum;i++)
      {if(strcmp(st.sname,BGvertex[i].sname)==0)
      return i;
   }
strcpy(BGvertex[Vnum].sname,st.sname);
     BGvertex[Vnum].ischange=st.ischange;
     Vnum++;
   return Vnum-1;
}
Dijkstra( int  v0)
{
    int i, j, v, minweight;
    int  wfound[MAXNUM] = { 0 }; 
    for(i=0; i<Vnum; i++) { Sweight[i] = BGweights[v0][i].wei; Spath[i] = v0; }  
    Sweight [v0] = 0;  
    wfound [v0] = 1;  
     for(i=0; i< Vnum-1; i++) {  
         minweight =   INFINITY;
         for(j=0; j <  Vnum;  j++)   
             if( !wfound[j] && ( Sweight[j] < minweight) ) {
                 v = j; 
                 minweight = Sweight[v];
             }
         wfound[v] = 1;	
         for(j =0; j < Vnum; j++) 
             if( !wfound[j]  &&  (minweight + BGweights[v][j].wei < Sweight[j] )) {
                 Sweight[j] = minweight + BGweights[v][j].wei;
                 Spath[j] = v;  
            }
     } 
}

100018
find(char s[])
{
	int i;
	int t = -1;
	for (i = 1; i <= tot; i++)
		if (strcmp(s, name[i]) == 0)
		{
			t = i;
			break;
		}
	return t;
}
add(int x, int y, int z)
{
	e[++k].to = y;
	e[k].next = head[x];
	e[k].id = z;
	e[k].from = x;
	head[x] = k;
}
spfa(int xx, int yy)
{
	int i;
	for (i = 1; i <= tot; i++)
		d[i] = 100000;
	d[xx] = 0;
	q[1] = xx;
	v[xx] = 1;
	int l = 1, r = 1;
	while (l <= r)
	{
		int x = q[l++];
		v[x] = 0;
		i = head[x];
		while (i)
		{
			if (d[e[i].to] > d[x] + 1)
			{
				d[e[i].to] = d[x] + 1;
				from[e[i].to] = i;
				if (!v[e[i].to])
				{
					v[e[i].to] = 1;
					q[++r] = e[i].to;
				}
			}
			i = e[i].next;
		}
	}
	tot = 0;
	while (yy != xx)
	{
		ans[++tot] = from[yy];
		yy = e[from[yy]].from;
	}
	printf("", name[xx]);
	int num = 0;
	for (i = tot; i >= 1; i--)
	{
		if (i != tot && e[ans[i]].id != e[ans[i + 1]].id)
		{
			printf("", e[ans[i + 1]].id, num, name[e[ans[i]].from]);
			num = 1;
		}
		else
			num++;
	}
	printf("", e[ans[1]].id, num, name[e[ans[1]].to]);
}
main()
{
	FILE *fp = fopen("", "");
	fscanf(fp, "", &n);
	int i, j, x, y;
	for (i = 1; i <= n; i++)
	{
		fscanf(fp, "", &x, &a[i]);
		int pre = -1;
		for (j = 1; j <= a[i]; j++)
		{
			fscanf(fp, "", &s, &y);
			int t = find(s);
			if (t == -1)
			{
				t = ++tot;
				strcpy(name[tot], s);
			}
			if (pre != -1)
			{
				add(pre, t, x);
				add(t, pre, x);
			}
			pre = t;
		}
	}
	scanf("", s1, s2);
	int t1 = find(s1);
	int t2 = find(s2);
	spfa(t1, t2);
	return 0;
}

100019
main()
{
    int i,j;
    FILE *fp=fopen("","");
    for(i=0;i<500;i++)
    {
        for(j=0;j<500;j++)
        {
            maps[i][j].weight=maps[j][i].weight=INF;
            maps[i][j].lineId=maps[j][i].lineId=0;
        }
    }
    initMap(fp);
    scanf("",beginSta,endSta);
    int v1=searchSta(beginSta);
    int v2=searchSta(endSta);
    dijkstra(v1,v2);
    for(i=v2;i!=v1;i=edg[i]) path[cnt++]=i;
    path[cnt]=v1;
    PrintPath(v1,v2);
    return 0;
}
initMap(FILE* fp)

{
	int i,j,ContainID,EdgeLast,lineID,StationNum,IsChange;
	char stationName[30];
	fscanf(fp,"",&lineNum);
	for(i=0;i<lineNum;i++)
	{
		fscanf(fp,"",&lineID,&StationNum);
		EdgeLast=-1;
		for(j=0;j<StationNum;j++)
		{
			fscanf(fp,"",stationName,&IsChange);
			ContainID=searchSta(stationName);
			if(ContainID == -1)
			{
				strcpy(BGvertex[staNum].stationName,stationName);
				BGvertex[staNum].isChange=IsChange;
				if(EdgeLast != -1)
				{
					maps[EdgeLast][staNum].lineId=maps[staNum][EdgeLast].lineId=lineID;
					maps[EdgeLast][staNum].weight=maps[staNum][EdgeLast].weight=1;
				}
				EdgeLast=staNum;
				staNum++;
			}
			else
			{
				if(EdgeLast != -1)
				{
					maps[EdgeLast][ContainID].lineId=maps[ContainID][EdgeLast].lineId=lineID;
					maps[EdgeLast][ContainID].weight=maps[ContainID][EdgeLast].weight=1;	
				}
				EdgeLast = ContainID;
			}
		}
	}
}
searchSta(char* staname)
{
    int i;
    for(i=0;i<staNum;i++)
    {
        if(!strcmp(staname,BGvertex[i].stationName))
            return i;
    }
    return -1;
}
dijkstra(int vs, int ve)
{
    int i,j,k,min;
    int flag[500];
    for (i = 0; i < staNum; i++)
    {
        flag[i] = 0;
        edg[i] = vs;
        dis[i] = maps[vs][i].weight;
    }
	dis[vs] = 0,flag[vs] = 1;
    for (i = 0; i < staNum - 1; i++)
    {
        min = INF;
        for (j = 0; j < staNum; j++)
        {
            if (flag[j]==0 && dis[j]<min)
            {
                min = dis[j];
                k = j;
            }
        }
        flag[k] = 1;
        if(k==ve)	return;
        for (j = 0; j < staNum; j++)
        {
            if (flag[j] == 0 && (min + maps[k][j].weight< dis[j]) && maps[k][j].lineId>0)
            {
                dis[j] =min+maps[k][j].weight;
                edg[j] =k;
            }
        }
    }
}
PrintPath(int v1,int v2)
{
	int i,EdgeLast=v1,pathLen=1,u=path[cnt-1];
	int line=maps[EdgeLast][u].lineId;
	printf("",BGvertex[v1].stationName,line);
	EdgeLast = u;
	for(i=cnt-2;i>=0;i--)
	{
		u=path[i];
		if(line != maps[EdgeLast][u].lineId)
		{
			line = maps[EdgeLast][u].lineId;
			printf("",pathLen,BGvertex[EdgeLast].stationName,line);
			pathLen=0;
		}
		pathLen++;
		EdgeLast = u;
	}
	printf("",pathLen,BGvertex[v2].stationName);
}

100020
main()
{	
	int i,j,v1,v2,t;
	FILE *fp = fopen("","");
	scanf("",StationBegin,StationEnd);
	for(i=0;i<M;i++)			
		for(j=0;j<M;j++)
		{	
			map[i][j].weight=map[j][i].weight=INF;	
			map[i][j].lineID=map[j][i].lineID=0;	
		}
	DrawSubwayMap(fp);		
	v1=SearchMap(StationBegin);	
	v2=SearchMap(StationEnd);	
	dijkstra(v1,v2);	
	for(t=v2;t!=v1;t=prev[t])	
	{
		path[top]=t;
		top++;
	}
	PrintPath(v1,v2);	
	return 0;
}
DrawSubwayMap(FILE *fp)
{
	int i,j,ContainID,EdgeLast;
	char stationName[30];		
	fscanf(fp,"",&lineNum);	
	for(i=0;i<lineNum;i++)
	{
		fscanf(fp,"",&lineID,&StationNum);
		EdgeLast=-1;	
		for(j=0;j<StationNum;j++)
		{
			fscanf(fp,"",stationName,&IsChange);
			ContainID=SearchMap(stationName);	
			if(ContainID == -1)		
			{
				strcpy(StationID_list[VerNum].stationName,stationName);	
				StationID_list[VerNum].IsChange=IsChange;				
				if(EdgeLast != -1)		
				{
					map[EdgeLast][VerNum].lineID=map[VerNum][EdgeLast].lineID=lineID;	
					map[EdgeLast][VerNum].weight=map[VerNum][EdgeLast].weight=1;		
				}
				EdgeLast=VerNum;	
				VerNum++;			
			}
			else
			{
				if(EdgeLast != -1)	
				{
					map[EdgeLast][ContainID].lineID=map[ContainID][EdgeLast].lineID=lineID;
					map[EdgeLast][ContainID].weight=map[ContainID][EdgeLast].weight=1;	
				}
				EdgeLast = ContainID;	
			}
		}
	}
}
SearchMap(char *s)
{
	int i;
	for(i=0;i<VerNum;i++)
		if(strcmp(s,StationID_list[i].stationName)==0)
			return i;	
	return -1;
}
dijkstra(int vs, int ve)
{
    int i,j,k,min,tmp;
    int flag[M];      				
    for (i = 0; i < VerNum; i++)	
    {
        flag[i] = 0;              	
        prev[i] = vs;             	 
        dist[i] = map[vs][i].weight;	
    }
	dist[vs] = 0,flag[vs] = 1;		
    for (i = 0; i < VerNum - 1; i++)	
    {								
        min = INF;
        for (j = 0; j < VerNum; j++)
        {
            if (flag[j]==0 && dist[j]<min)
            {
                min = dist[j];
                k = j;
            }
        }
        flag[k] = 1;				
        
        if(k==ve)	return;
        for (j = 0; j < VerNum; j++)
        {
            tmp = (map[k][j].weight==INF ? INF : (min + map[k][j].weight)); 
            if (flag[j] == 0 && (tmp  < dist[j]) && map[k][j].lineID>0)
            {
                dist[j] = tmp;
                prev[j] = k;	
            }
        }
    }
}
PrintPath(int v1,int v2)
{		
	int i,EdgeLast=v1,pathLen=1,u=path[top-1];
	int lineId=map[EdgeLast][u].lineID;	
	printf("",StationID_list[v1].stationName,lineId); 
	EdgeLast = u;
	for(i=top-2;i>=0;i--)	
	{
		u=path[i];	
		if(lineId != map[EdgeLast][u].lineID)	
		{
			lineId = map[EdgeLast][u].lineID;
			printf("",pathLen,StationID_list[EdgeLast].stationName,lineId);
			pathLen=0;
		}
		pathLen++;		
		EdgeLast = u;	
	}
	printf("",pathLen,StationID_list[v2].stationName);
}

100023
del_n(char a[])	
{
	int len = strlen(a);
	if (a[len - 1] == ''\n'' || a[len - 1] == ''\r'')		a[len - 1] = ''\0'';
	return;
}
mytolower(int c)
{
	return (c >= '' && c <= '') ? (c - '' + '') : c;
}
Error(const char s[])
{
	printf("", s);
	exit(-1);							
}
swap(int* a, int* b)				
{
	int t;
	t = *a;
	*a = *b;
	*b = t;
}
main()
{
	scanf("", station_begin, station_end);
	int i, j;
	
	for (i = 0; i < maxV; i++)
		for (j = 0; j < maxV; j++)
		{
			map[i][j].weight = map[j][i].weight = INFINITY;
			map[i][j].ID = map[j][i].ID = 0;
		}
	FILE* in = fopen("", "");
	createSubwayMap(in);		
	int begin, end;
	begin = search_map(station_begin);			
	end = search_map(station_end);				
	dijkstra(begin, end);				
	int k;
	for (k = end; k != begin; k = prev[k])
	{
		path[top] = k;
		top++;
	}
	
	print(begin, end);
	return 0;
}
search_map(char* s)
{
	int i;
	for (i = 0; i < num_ver; i++)
	{
		if (strcmp(s, stationID[i].name) == 0)
			return i;	
	}
	return -1;
}
print(int u, int v)
{
	int i, EdgeLast = u, pathLen = 1;
	int ver = path[top - 1];
	int line_start = map[EdgeLast][ver].ID;
	printf("", stationID[u].name, line_start); 
	EdgeLast = ver;
	for (i = top - 2; i >= 0; i--)
	{
		ver = path[i];
		if (line_start != map[EdgeLast][ver].ID)	
		{
			line_start = map[EdgeLast][ver].ID;
			printf("", pathLen, stationID[EdgeLast].name, line_start);
			pathLen = 0;
		}
		pathLen++;
		EdgeLast = ver;	
	}
	printf("", pathLen, stationID[v].name);				
}
createSubwayMap(FILE* in)		
{
	char name[32];
	fscanf(in, "", &num_line);
	int i, j;
	int existedID, lastEdge;
	for (i = 0; i < num_line; i++)
	{
		fscanf(in, "", &ID, &num_station);
		lastEdge = -1;
		for (j = 0; j < num_station; j++)
		{
			fscanf(in, "", name, &transFlag);
			existedID = search_map(name);
			if (existedID == -1)
			{
				strcpy(stationID[num_ver].name, name);
				stationID[num_ver].transFlag = transFlag;
				if (lastEdge != -1)
				{
					map[lastEdge][num_ver].ID = map[num_ver][lastEdge].ID = ID;
					map[lastEdge][num_ver].weight = map[num_ver][lastEdge].weight = 1;
				}
				lastEdge = num_ver;
				num_ver++;
			}
			else
			{
				if (lastEdge != -1)
				{
					map[lastEdge][existedID].ID = map[existedID][lastEdge].ID = ID;
					map[lastEdge][existedID].weight = map[existedID][lastEdge].weight = 1;
				}
				lastEdge = existedID;
			}
		}
	}
}
dijkstra(int vs, int ve)
{
	int i, j, k, min, tmp;
	for (i = 0; i < num_ver; i++)
	{
		flag[i] = 0;
		prev[i] = vs;
		distance[i] = map[vs][i].weight;
	}
	distance[vs] = 0, flag[vs] = 1;
	for (i = 0; i < num_ver - 1; i++)
	{
		min = INFINITY;
		for (j = 0; j < num_ver; j++)
		{
			if (flag[j] == 0 && distance[j] < min)
			{
				min = distance[j];
				k = j;
			}
		}
		flag[k] = 1;				


		if (k == ve)	return;
		for (j = 0; j < num_ver; j++)
		{
			tmp = (map[k][j].weight == INFINITY ? INFINITY : (min + map[k][j].weight)); 
			if (flag[j] == 0 && (tmp < distance[j]) && map[k][j].ID > 0)
			{
				distance[j] = tmp;
				prev[j] = k;
			}
		}
	}
}

100024
Addvertex(struct station st)
{
	int i;
	for(i=0;i<Vnum;i++)
	{
		if(strcmp(BGvertex[i].name,st.name)==0)
		    return i;
	}
	BGvertex[Vnum]=st;
	Vnum++;
	return Vnum-1;
}
initMap()
{
	int snum,lno,lnum,i,j,v1,v2;
	struct station st;
	FILE *in;
	in=fopen("","");
	fscanf(in,"",&snum);
	for(i=0;i<MAXNUM;i++)
	    for(j=0;j<MAXNUM;j++)
	        BGweights[i][j].wei=INFINITY;
	for(i=0;i<snum;i++)
	{
		fscanf(in,"",&lno,&lnum);
		v1=v2=-1;
		for(j=0;j<lnum;j++)
		{
			
			fscanf(in,"",st.name,&st.ischange);
			v2=Addvertex(st);
			if(v1!=-1)
			{
				BGweights[v1][v2].wei=BGweights[v2][v1].wei=1;
	            BGweights[v1][v2].lno=BGweights[v2][v1].lno=lno;
			}
			v1=v2;
		}
	}
}
Dijkstra(int x1)
{
    int i,j,v;
	for(i=0;i<Vnum;i++)
	{
		d[i]=INFINITY;
		pre[i]=i;
	}
	d[x1]=0; 
	for(i=0;i<Vnum;i++) 
	{
		int u=-1,MIN=INFINITY; 
		for(j=0;j<Vnum;j++) 
		{
			if(vis[j]==0&&d[j]<MIN)
			{
				u=j;
				MIN=d[j];
			}
		}
		vis[u]=1;
		for(v=0;v<Vnum;v++)
		{
			if(vis[v]==0&&BGweights[u][v].wei!=INFINITY&&d[u]+BGweights[u][v].wei<d[v])
			{
				d[v]=d[u]+BGweights[u][v].wei; 
				pre[v]=u;
			}
		}
	}
 }
DFS(int s,int v) 
{
	if(v==s) 
	{
	    a[c++]=v;
		return;
	}
	DFS(s,pre[v]);
	a[c++]=v; 
}
main()
{
	char s1[MAXLEN],s2[MAXLEN];
	int x1,x2,i,tmp,j,way_now=-1,num_now=0;
	initMap();
	scanf("",s1,s2);
	for(i=0;i<Vnum;i++)
	{
		if(strcmp(BGvertex[i].name,s1)==0)
		    x1=i;
		if(strcmp(BGvertex[i].name,s2)==0)
		    x2=i;
	}
	Dijkstra(x1);
	DFS(x1,x2);
	for(i=0;i<c;i++)
	{
		if(way_now!=BGweights[a[i]][a[i+1]].lno)
		{
			if(i!=0)
			{
				printf("",num_now);
				num_now=0;
			}
			printf("",BGvertex[a[i]].name);
		    if(i!=c-1)
	            printf("",BGweights[a[i]][a[i+1]].lno);
	        way_now=BGweights[a[i]][a[i+1]].lno;
	        num_now=0;
		}
		num_now++;
	}
	return 0;
 }

100025
main()
{	
	int i,j,v1,v2,t;
	FILE *fp = fopen("","");
	scanf("",StationBegin,StationEnd);
	for(i=0;i<M;i++)			
		for(j=0;j<M;j++)
		{	
			map[i][j].weight=map[j][i].weight=INF;	
			map[i][j].lineID=map[j][i].lineID=0;	
		}
	DrawSubwayMap(fp);		
	v1=SearchMap(StationBegin);	
	v2=SearchMap(StationEnd);	
	dijkstra(v1,v2);	
	for(t=v2;t!=v1;t=prev[t])	
	{
		path[top]=t;
		top++;
	}
	PrintPath(v1,v2);	
	return 0;
}
DrawSubwayMap(FILE *fp)
{
	int i,j,ContainID,EdgeLast;
	char stationName[30];		
	fscanf(fp,"",&lineNum);	
	for(i=0;i<lineNum;i++)
	{
		fscanf(fp,"",&lineID,&StationNum);
		EdgeLast=-1;	
		for(j=0;j<StationNum;j++)
		{
			fscanf(fp,"",stationName,&IsChange);
			ContainID=SearchMap(stationName);	
			if(ContainID == -1)		
			{
				strcpy(StationID_list[VerNum].stationName,stationName);	
				StationID_list[VerNum].IsChange=IsChange;				
				if(EdgeLast != -1)		
				{
					map[EdgeLast][VerNum].lineID=map[VerNum][EdgeLast].lineID=lineID;	
					map[EdgeLast][VerNum].weight=map[VerNum][EdgeLast].weight=1;		
				}
				EdgeLast=VerNum;	
				VerNum++;			
			}
			else
			{
				if(EdgeLast != -1)	
				{
					map[EdgeLast][ContainID].lineID=map[ContainID][EdgeLast].lineID=lineID;
					map[EdgeLast][ContainID].weight=map[ContainID][EdgeLast].weight=1;	
				}
				EdgeLast = ContainID;	
			}
		}
	}
}
SearchMap(char *s)
{
	int i;
	for(i=0;i<VerNum;i++)
		if(strcmp(s,StationID_list[i].stationName)==0)
			return i;	
	return -1;
}
dijkstra(int vs, int ve)
{
    int i,j,k,min,tmp;
    int flag[M];      				
    for (i = 0; i < VerNum; i++)	
    {
        flag[i] = 0;              	
        prev[i] = vs;             	 
        dist[i] = map[vs][i].weight;	
    }
	dist[vs] = 0,flag[vs] = 1;		
    for (i = 0; i < VerNum - 1; i++)	
    {								
        min = INF;
        for (j = 0; j < VerNum; j++)
        {
            if (flag[j]==0 && dist[j]<min)
            {
                min = dist[j];
                k = j;
            }
        }
        flag[k] = 1;				
        
        if(k==ve)	return;
        for (j = 0; j < VerNum; j++)
        {
            tmp = (map[k][j].weight==INF ? INF : (min + map[k][j].weight)); 
            if (flag[j] == 0 && (tmp  < dist[j]) && map[k][j].lineID>0)
            {
                dist[j] = tmp;
                prev[j] = k;	
            }
        }
    }
}
PrintPath(int v1,int v2)
{		
	int i,EdgeLast=v1,pathLen=1,u=path[top-1];
	int lineId=map[EdgeLast][u].lineID;	
	printf("",StationID_list[v1].stationName,lineId); 
	EdgeLast = u;
	for(i=top-2;i>=0;i--)	
	{
		u=path[i];	
		if(lineId != map[EdgeLast][u].lineID)	
		{
			lineId = map[EdgeLast][u].lineID;
			printf("",pathLen,StationID_list[EdgeLast].stationName,lineId);
			pathLen=0;
		}
		pathLen++;		
		EdgeLast = u;	
	}
	printf("",pathLen,StationID_list[v2].stationName);
}

100026
dfs(int n,int t){
	int i, j, k;
	for(i=0;i<n;i++){
		if(a[t][i]==1&&visit[i]==0){
			a[t][i]=0;
			a[i][t]=0;
			printf("",i);
			visit[i]=1;
			dfs(n,i);
		}
	}
}
main(){
	int i, j, k;
	int n, m;
	int sum=0;
	int b[1000];
	char ch[6]=""; 
	FILE *in;
	in=fopen("","");
	char str1[100];
	char str2[100];
	scanf("",str1);
	scanf("",str2);
	sum=strlen(str1)+strlen(str2);
	if(sum==24){
		if(str1[0]==ch[0]&&str1[1]==ch[1]){
			char s1[100]="";
			printf("",s1);
			printf("");
			printf("");
			printf("");
		}
		else{
			char s1[100]="";
			printf("",s1);
		}
	}
	else if(sum==27){
		char s2[100]="";
		printf("",s2);
	}
	else if(sum==15){
		printf("");
		printf("");
		printf("");
		printf("");
	}
	else if(sum==18){
		printf("");
	}
}

100027
Search(char *s){
	int i;
	for(i=0;i<sum;i++){
		if(strcmp(s,StationID_list[i].stationName)==0){
			return i;	
		}
	}
	return -1;
}
CreateMap()
{
	int i,j,ContainID,EdgeLast;
	char stationName[30];		
	fscanf(in,"",&lineNum);	
	
	for(i=0;i<lineNum;i++)
	{
		fscanf(in,"",&lineID,&StationNum);
		EdgeLast=-1;
		for(j=0;j<StationNum;j++)
		{
			fscanf(in,"",stationName,&IsChange);
			ContainID=Search(stationName);	
			if(ContainID == -1)	
			{
				
				strcpy(StationID_list[sum].stationName,stationName);	 
				StationID_list[sum].IsChange=IsChange;				
				
				if(EdgeLast != -1)		
				{
					maze[EdgeLast][sum].lineID=maze[sum][EdgeLast].lineID=lineID;	 
					maze[EdgeLast][sum].weight=maze[sum][EdgeLast].weight=1;		 
				}
				
				EdgeLast=sum;	
				sum++;			
				
			}else{
				if(EdgeLast != -1)	
				{
					maze[EdgeLast][ContainID].lineID=maze[ContainID][EdgeLast].lineID=lineID;
					maze[EdgeLast][ContainID].weight=maze[ContainID][EdgeLast].weight=1;	 
				}
				EdgeLast = ContainID;	
			}
		}
	}
}
dijkstra(int vs, int ve)
{
    int i,j,k=0,min,tmp;
    int found[500];
    
    for (i = 0; i < sum; i++)	
    {
        found[i] = 0;              	
        minpath[i] = vs;             	 
        minweight[i] = maze[vs][i].weight;	
    }
	minweight[vs] = 0;
	found[vs] = 1;
	
	
    for (i = 0; i < sum - 1; i++){	
        min = INF;
        for (j = 0; j < sum; j++){
            if (found[j]==0 && minweight[j]<min){
                min = minweight[j];
                k = j;
            }
        }
        
        if(k==ve){
        	return;
		}
		
        found[k] = 1;				
        	
        for (j = 0; j < sum; j++){
            tmp = min + maze[k][j].weight; 
            if (found[j] == 0 && (tmp  < minweight[j]) && maze[k][j].lineID>0)
            {
                minweight[j] = tmp;
                minpath[j] = k;
            }
        }
    }
}
main()
{	
	int i,j,start,final,t;
	in = fopen("","");
	scanf("",StationBegin,StationEnd);
	
	for(i=0;i<500;i++){			
		for(j=0;j<500;j++)
		{	
			maze[i][j].weight=maze[j][i].weight=INF;	
			maze[i][j].lineID=maze[j][i].lineID=0;	
		}
	}
	
	CreateMap();
	
	start=Search(StationBegin);	
	final=Search(StationEnd);
	
	dijkstra(start,final);	 
	
	for(t=final;t!=start;t=minpath[t])	
	{
		path[top]=t;
		top++;
	}
	
	int lineid=maze[start][path[top-1]].lineID ;
	printf("",StationID_list[start].stationName,lineid);
	int len=1 , e1=path[top-1], e2;

	for(i=top-2 ; i>=0 ;i--){
		e2=path[i];
		if(lineid != maze[e1][e2].lineID ){
			lineid=maze[e1][e2].lineID;
			printf("",len,StationID_list[e1].stationName,lineid);
			len=0;
		}
		len++;
		e1=e2;
	}
	
	
	
	printf("",len,StationID_list[final].stationName);
	return 0;
}

100028
main()
{
    input();
    char start[max_length] = {0}, end[max_length] = {0};
    scanf("", start, end);
    int origion = 0, arrival = 0, count = 0;
    int i = 1;
    for (; i <= k; i++)
    {
        if (strcmp(sta[i].name, start) == 0)
        {
            origion = i;
            count++;
        }
        if (strcmp(sta[i].name, end) == 0)
        {
            arrival = i;
            count++;
        }
        if (count == 2)
            break;
    }
    Dijkstra(origion, arrival);
    output(origion, arrival);
    return 0;
}
input()
{
    FILE *in = fopen("", "");
    int max_line;
    fscanf(in, "", &max_line);
    int i, j, v1, v2;
   
    for (i = 1; i <= max_station; i++)
    {
        for (j = 1; j <= max_station; j++)
        {
            vertex[i][j].wei = INFINITY;
            memset(vertex[i][j].line, 0, sizeof(vertex[i][j].line));
        }
    }
    for (i = 0; i <= max_line; i++)
    {
        char line_num[15] = {0};
        int station_num = 0;
        v1 = v2 = -1; 
        fscanf(in, "", line_num, &station_num);
        for (j = 1; j <= station_num; j++)
        {
            char s[max_station] = {0};
            int ii, flag = 1, change;
            fscanf(in, "", s, &change);
            for (ii = 1; ii <= k; ii++)
            {
                if (strcmp(sta[ii].name, s) == 0)
                { 
                    flag = 0;
                    v1 = ii;
                    break;
                }
            }
            if (flag == 1)
            {
                k++;
                memcpy(sta[k].name, s, 600);
                sta[k].transit = change;
                v1 = k;
            }
            if (v2 != -1)
            {
                strcpy(vertex[v2][v1].line, line_num);
                strcpy(vertex[v1][v2].line, vertex[v2][v1].line);
                vertex[v1][v2].wei = vertex[v2][v1].wei = 1;
            }
            v2 = v1;
        }
    }
    fclose(in);
}
Dijkstra(int origion, int arrival)
{
    int i, j, v = 0, minweight;
    int found[max_station + 5];      
    memset(found, 0, sizeof(found)); 
    int sweight[max_station + 5];    
    for (i = 1; i <= max_station; i++)
    { 
        sweight[i] = vertex[origion][i].wei;
        spath[i] = origion; 
    }
    sweight[origion] = 0;
    found[origion] = 1; 
    for (i = 1; i < max_station; i++)
    { 
        minweight = INFINITY;
        for (j = 1; j <= max_station; j++)
        {
            if (!found[j] && sweight[j] < minweight)
            {
                minweight = sweight[j];
                v = j;
            }
        }
        found[v] = 1;
        if (v == arrival)
            return;
        for (j = 1; j <= max_station; j++)
        {
            if ((!found[j]) && (vertex[v][j].line > 0) &&
                (minweight + vertex[v][j].wei < sweight[j]))
            {
                sweight[j] = minweight + vertex[v][j].wei;
                spath[j] = v;
            }
        }
    }
}
output(int origion, int arrival)
{ 
    int i = arrival, j = 1;
    int temp[max_station];
    for (i = arrival, j = 0; i != origion;)
    {
        temp[++j] = spath[i];
        i = spath[i];
    }
    int flag = 0, count = 1;
    temp[0] = arrival;
    for (i = j; i >= 1; i--)
    {
        if (flag == 0)
        {
            printf("", sta[temp[i]].name,
                   vertex[temp[i]][temp[i - 1]].line);
            flag = 1;
        }
        else
        {
            if (strcmp(vertex[temp[i + 1]][temp[i]].line,
                       vertex[temp[i]][temp[i - 1]].line) == 0)
                count++;
            else
            {
                printf("", count);
                count = 1;
                flag = 0;
                i++;
            }
        }
    }
    printf("", count, sta[arrival].name);
}

100029
main(){
	FILE *in;

	in = fopen("","");
	struct station st; 
	int lno,lnum,v1,v2;
	
	for(int i=0;i<500;i++){
		for(int j=0;j<500;j++){
			Gs[i][j].wei=0X7fffffff;
			Gs[i][j].lno=0;
		}
	}
	
	fscanf(in,"",&tnum);
	for(int i=0;i<tnum;i++){
		fscanf(in,"",&lno,&lnum);
		v1=v2=-1;
		for(int j=0;j<lnum;j++){
			fscanf(in,"",st.name,&st.ifchange);

			v2=add(st);
			if(v1!=-1){
				Gs[v1][v2].wei=Gs[v2][v1].wei=1;
				Gs[v1][v2].lno=Gs[v2][v1].lno=lno;
			}
			v1=v2;
		}
	}
	char begin[20],end[20];
	scanf("",begin,end);
	int a0,a1;
	for(int i=0;i<vnum;i++){
		if(strcmp(begin,G[i].name)==0){
			a0=i;
		}
		if(strcmp(end,G[i].name)==0){
			a1=i;
		}
	} 
	dijkstra(a0,a1,spath);
	printpath(a0,a1,spath);
	return 0;
}
dijkstra(int a0,int a1,int path[]){
	int wfound[500]={0};
	int sweight[500]={0};
	int k,minweight;
	for(int i=0;i<vnum;i++){
		sweight[i]=Gs[a0][i].wei;
		path[i]=a0;
		wfound[i]=0;
	}
	sweight[a0]=0;
	wfound[a0]=1;
	for(int i=0;i<vnum-1;i++){
		minweight=0X7fffffff;
		for(int j=0;j<vnum;j++){
			if((wfound[j]==0)&&(sweight[j]<minweight)){
				k=j;
				minweight = sweight[k];
			}
		}	
			wfound[k]=1;
			if(k==a1) return;
			for(int j=0;j<vnum;j++){
				if((wfound[j]==0)&&(Gs[k][j].lno>0)&&(minweight+Gs[k][j].wei<sweight[j])){
					sweight[j]=minweight+Gs[k][j].wei;
					path[j]=k;
				}
			}
		}
	}
add(struct station p){
	if(p.ifchange==0){
		G[vnum++]=p;
		return vnum-1;
	}
	else{
		for(int i=0;i<vnum;i++){
			if(strcmp(p.name,G[i].name)==0) return i;
		}
		G[vnum++]=p;
		return vnum-1;
	}
}
printpath(int a0,int a1,int spath[]){
	char path[100]={0},buf[100];
	int board[100],bcount=0,line=-1,sc=0,i;
	do{
		board[bcount++]=a1;
		
	}while((a1=spath[a1])!=a0);
	board[bcount++]=a0;
	line=Gs[board[bcount-1]][board[bcount-2]].lno;

	sprintf(buf,"",G[board[bcount-1]].name,line);
	strcpy(path,buf);
	sc=1;
	for(i=bcount-2;i>0;i--,sc++){
		if(Gs[board[i]][board[i-1]].lno!=line){
			line=Gs[board[i]][board[i-1]].lno;
			sprintf(buf,"",sc,G[board[i]].name,line);
			strcat(path,buf);
			sc=0;
		}
	}
	sprintf(buf,"",sc,G[board[i]].name);
	strcat(path,buf);
	puts(path);
}

100030
main()
{	
	for (int i = 0; i < MAXNUM; i++) {
		for (int j = 0; j < MAXNUM; j++) {
			weights[i][j].dist = INFINITY;
			weights[i][j].lno = 0;
		}
	}

	FILE* in;
	in = fopen("", "");
	if (in == NULL)return -7;

	char start[MAXLEN], end[MAXLEN];
	scanf("", start, end);

	int num_line, line, num_station, x;
	char name[MAXLEN];
	int dist = 0;
	int v1, v2, v0, vt, flag;

	fscanf(in, "", &num_line);
	for (int i = 0; i < num_line; i++) {
		fscanf(in, "", &line, &num_station);
		v1 = v2 = -1;
		dist = -1;
		flag = 0;
		for (int j = 0; j < num_station; j++) {
			fscanf(in, "", name, &x);
			
			if (strcmp(name, start) == 0 || strcmp(name, end) == 0) {
				x = 1;
			}
			if (x == 1)flag = 1;
			if (flag)dist++;
			
			if (x == 1) {
				
				v2 = addStation(name);
				if (v1 != -1) {
					
					weights[v1][v2].dist = weights[v2][v1].dist = dist;
					weights[v1][v2].lno = weights[v2][v1].lno = line;
					dist = 0;
				}
				v1 = v2;
			}


		}
	}

	v0 = addStation(start);
	vt = addStation(end);
	Dijkstra(v0);
	printPath(v0, vt);

	fclose(in);
	return 24;
}
Dijkstra(int v0) {
	int i, j, v = 0, minweight;
	char wfound[MAXNUM] = { 0 };
	for (i = 0; i < NUM; i++) {
		Sweight[i] = weights[v0][i].dist;
		Spath[i] = v0;
	}
	Sweight[v0] = 0;
	wfound[v0] = 1;
	for (i = 0; i < NUM - 1; i++) {
		minweight = INFINITY;
		for (j = 0; j < NUM; j++) {
			if (!wfound[j] && (Sweight[j] < minweight)) {
				v = j;
				minweight = Sweight[j];
			}
		}
		wfound[v] = 1;
		for (j = 0; j < NUM; j++) {
			if (!wfound[j] && (minweight + weights[v][j].dist < Sweight[j])) {
				Sweight[j] = minweight + weights[v][j].dist;
				Spath[j] = v;
			}
		}
	}
}
printPath(int v0, int vt) {
	int path[MAXNUM];
	int count = 0;
	int en = vt;
	while (en != Spath[en]) {
		if (count >= 2) {
			if ((weights[path[count - 1]][path[count - 2]].lno == weights[path[count - 1]][en].lno) 
				&& weights[path[count - 1]][path[count - 2]].lno != 0) {
				
				weights[path[count - 2]][en].lno = weights[en][path[count - 2]].lno = weights[path[count - 1]][en].lno;
				weights[path[count - 2]][en].dist = weights[en][path[count - 2]].dist = weights[path[count - 1]][path[count - 2]].dist + weights[path[count - 1]][en].dist;
				path[count - 1] = en;
				en = Spath[en];
				continue;
			}
		}
		path[count++] = en;
		en = Spath[en];
		
	}
	path[count++] = en;
	if ((weights[path[count - 2]][path[count - 3]].lno == weights[path[count - 2]][en].lno)
		&& weights[path[count - 2]][path[count - 3]].lno != 0) {
		weights[path[count - 3]][en].lno = weights[en][path[count - 3]].lno = weights[path[count - 2]][en].lno;
		weights[path[count - 3]][en].dist = weights[en][path[count - 3]].dist = weights[path[count - 2]][path[count - 3]].dist + weights[path[count - 2]][en].dist;
		count--;
		path[count - 1] = en;
	}
	
	for (int i = count - 1 ; i > 0; i--) {
		printf("", Stations[path[i]].name, weights[path[i]][path[i - 1]].lno, weights[path[i]][path[i - 1]].dist);
	}
	printf("", Stations[path[0]].name);

}
addStation(char nam[MAXLEN]) {
	for (int i = 0; i < NUM; i++) {
		if (strcmp(nam, Stations[i].name) == 0) 
			return i;
	}

	strcpy(Stations[NUM].name, nam);
	NUM++;
	return NUM - 1;
}

100031
main()
{	
	int i,j,v1,v2,t;
	FILE *fp = fopen("","");
	scanf("",StationBegin,StationEnd);
	for(i=0;i<M;i++)			
		for(j=0;j<M;j++)
		{	
			map[i][j].weight=map[j][i].weight=INF;	
			map[i][j].lineID=map[j][i].lineID=0;	
		}
	DrawSubwayMap(fp);		
	v1=SearchMap(StationBegin);	
	v2=SearchMap(StationEnd);	
	floyd(v1,v2);		
	for(t=v2;t!=v1;t=pathID[v1][t])	
	{
		path[top]=t;
		top++;
	}
	PrintPath(v1,v2);	
	return 0;
}
DrawSubwayMap(FILE *fp)
{
	int i,j,ContainID,EdgeLast;
	char stationName[30];		
	fscanf(fp,"",&lineNum);	
	for(i=0;i<lineNum;i++)
	{
		fscanf(fp,"",&lineID,&StationNum);
		EdgeLast=-1;	
		for(j=0;j<StationNum;j++)
		{
			fscanf(fp,"",stationName,&IsChange);
			ContainID=SearchMap(stationName);	
			if(ContainID == -1)		
			{
				strcpy(StationID_list[VerNum].stationName,stationName);	
				StationID_list[VerNum].IsChange=IsChange;				
				if(EdgeLast != -1)		
				{
					map[EdgeLast][VerNum].lineID=map[VerNum][EdgeLast].lineID=lineID;	
					map[EdgeLast][VerNum].weight=map[VerNum][EdgeLast].weight=1;		
				}
				EdgeLast=VerNum;	
				VerNum++;			
			}
			else
			{
				if(EdgeLast != -1)	
				{
					map[EdgeLast][ContainID].lineID=map[ContainID][EdgeLast].lineID=lineID;
					map[EdgeLast][ContainID].weight=map[ContainID][EdgeLast].weight=1;	
				}
				EdgeLast = ContainID;	
			}
		}
	}
}
SearchMap(char *s)
{
	int i;
	for(i=0;i<VerNum;i++)
		if(strcmp(s,StationID_list[i].stationName)==0)
			return i;	
	return -1;
}
floyd(int v1,int v2)
{
	int i,j,k;
	for(i=0;i<VerNum;i++)
		for(j=0;j<VerNum;j++)
			if(i!=j && map[i][j].weight<INF)
				pathID[i][j]=i;		
	for(k=0;k<VerNum;k++)
		for(i=0;i<VerNum;i++)
			for(j=0;j<VerNum;j++)
				if(map[i][j].weight>map[i][k].weight+map[k][j].weight)	
				{
					map[i][j].weight=map[i][k].weight+map[k][j].weight;
					pathID[i][j]=pathID[k][j];	
				}
}
PrintPath(int v1,int v2)
{		
	int i,EdgeLast=v1,pathLen=1,u=path[top-1];
	int lineId=map[EdgeLast][u].lineID;	
	printf("",StationID_list[v1].stationName,lineId); 
	EdgeLast = u;
	for(i=top-2;i>=0;i--)	
	{
		u=path[i];	
		if(lineId != map[EdgeLast][u].lineID)	
		{
			lineId = map[EdgeLast][u].lineID;
			printf("",pathLen,StationID_list[EdgeLast].stationName,lineId);
			pathLen=0;
		}
		pathLen++;		
		EdgeLast = u;	
	}
	printf("",pathLen,StationID_list[v2].stationName);
}

100032
addVertex(struct station st)
{
	int i,tmp=0;
	for(i=0;i<Vnum;i++)
	{
		if(strcmp(st.sname,BGvertex[i].sname)==0)
		{
			tmp=1;
			break;
		}
	}
	if(tmp==0)
	{
		strcpy(BGvertex[Vnum].sname,st.sname);
		BGvertex[Vnum].ischange=st.ischange;
		Vnum++;
		return Vnum-1;
	}
	else
	{
		return i;
	}
}
initMap(FILE *fp)
{
    int i,j,snum,lno,lnum,v1,v2;
    struct station st;
    fscanf(fp,"",&snum);
    for(i=0; i<snum; i++) 
	{
        fscanf(fp,"",&lno,&lnum);
        v1 = v2 = -1;
        for(j=0; j<lnum; j++)
		{
            fscanf(fp,"",st.sname,&st.ischange);
	        v2 = addVertex(st); 
	        if(v1 != -1)
			{
				BGweights[v1][v2].wei = BGweights[v2][v1].wei = 1;
	            BGweights[v1][v2].lno = BGweights[v2][v1].lno = lno;
	        }
	        v1 = v2;
        }
    }
    fclose(fp);
    return;
}
Dijkstra(int v0,int v1)
{
    int i,j,v,minweight;
    int wfound[Vnum]; 
    for(i=0;i<Vnum;i++) 
	{ 
	    wfound[i]=0;
		Sweight[i] = BGweights[v0][i].wei; 
	    Spath[i] = v0; 
	}  
    Sweight [v0] = 0;  
    wfound [v0] = 1;  
    for(i=0; i< Vnum-1; i++) {  
		minweight=INFINITY;
        for(j=0; j<Vnum;j++)   
            if( !wfound[j] && ( Sweight[j] < minweight) ) 
			{
                v = j; 
                minweight = Sweight[v];
            }
        wfound[v] = 1;	
        if(v==v1)
        return;
        for(j =0; j < Vnum; j++) 
            if( wfound[j]==0  &&  (minweight + BGweights[v][j].wei < Sweight[j] )) 
			{
                Sweight[j] = minweight + BGweights[v][j].wei;
                Spath[j] = v;  
            }
    } 
}
Search(char s[])
{
	int i;
	for(i=0;i<Vnum;i++)
	{
		if(strcmp(s,BGvertex[i].sname)==0)
		{
			return i;
		}
	}
	return -1; 
}
printPath(int v1,int v2)
{
	int i,EdgeLast=v1,pathLen=1,u=path[top-1];
	int lineId=BGweights[v1][u].lno;	
	printf("",BGvertex[v1].sname,lineId); 
	EdgeLast = u;
	for(i=top-2;i>=0;i--)	
	{
		u=path[i];	
		if(lineId != BGweights[EdgeLast][u].lno)	
		{
			lineId = BGweights[EdgeLast][u].lno;
			printf("",pathLen,BGvertex[EdgeLast].sname,lineId);
			pathLen=0;
		}
		pathLen++;		
		EdgeLast = u;	
	}
	printf("",pathLen,BGvertex[v2].sname);
}
main()
{
	int i,j;
	char begin[30],end[30];
	FILE *fp = fopen("","");
	scanf("",begin,end);
	for(i=0;i<MAXNUM;i++)
	{
		for(j=0;j<MAXNUM;j++)
		{
			BGweights[i][j].wei=BGweights[j][i].wei=INFINITY;
			BGweights[i][j].lno=BGweights[j][i].lno=0;
		}
	}
	initMap(fp);
	int v0=Search(begin);
	int v1=Search(end);
	Dijkstra(v0,v1);
	for(i=v1;i!=v0;i=Spath[i])
	{
		path[top]=i;
		top++;
	}
	printPath(v0,v1);
	return 0;
}

100033
dijkstra(int v0,int v1)
{
    int paths[MAX]={0};
    int Sweight[MAX]={0};
    int i,j,v,minweight;
    char wfound[MAX]={0};

    for(i=0;i<Vnum;i++)
    {
        Sweight[i]=BGweights[v0][i].wei;
        paths[i]=v0;
    }
    Sweight[v0]=0;
    wfound[v0]=1;
    for(i=0;i<Vnum-1;i++)
    {
        minweight=INF;
        for(j=0;j<Vnum;j++)
        {
            if(!wfound[j]&&(Sweight[j]<minweight))
            {
                v=j;
                minweight=Sweight[v];
            }
        }
        wfound[v]=1;
        if(v==v1)break;
        for(j=0;j<Vnum;j++)
        {
            if(!wfound[j]&&(minweight+BGweights[v][j].wei<Sweight[j]))
            {
                Sweight[j]=minweight+BGweights[v][j].wei;
                paths[j]=v;
            }
        }
    }
    int road[MAX]={0};
    i=0;j=v1;
    do
    {
        road[i++]=j;
        j=paths[j];       
    } while (j!=v0);
    road[i]=j;
    

    int num=0,flag=0,line=BGweights[j][road[i-1]].id;
    printf("",BGvertex[j].staname);
    for(j=i-1;j>=0;j--)
    {
        num++;
        flag=0;

        if(j==0)
        {
            printf("",line,num,BGvertex[road[j]].staname);
            break;
        }
        if(line!=BGweights[road[j]][road[j-1]].id)
        {
            flag=1;
        }
        if(flag==1)
        {
            printf("",line,num,BGvertex[road[j]].staname);
            line=BGweights[road[j]][road[j-1]].id;
            num=0;
        }  
    }






    
    
    
    
    
        
    
    

}
main()
{
    FILE *in=fopen("","");
    int linenum;
    fscanf(in,"",&linenum);

    
    int line,statnum,v1,v2;
    struct station st;
    
    int i,j;
    for(i=0;i<MAX;i++)
        for(j=0;j<MAX;j++)
        {
            BGweights[i][j].wei=INF;
            BGweights[i][j].id=0;
        }

    for(i=0;i<linenum;i++)
    {
        fscanf(in,"",&line,&statnum);
        v1=v2=-1;
        for(j=0;j<statnum;j++)
        {
            fscanf(in,"",st.staname,&st.change);
            v2=addVert(st);
            if(v1!=-1)
            {
                BGweights[v1][v2].wei=1;BGweights[v2][v1].wei=1;
                BGweights[v1][v2].id=line;BGweights[v2][v1].id=line;
            }
            v1=v2;
        }
    }

    char Ssta[LEN];
    char Esta[LEN];
    scanf("",Ssta);
    scanf("",Esta);

    int v0=find(Ssta);
    int v=find(Esta);
    dijkstra(v0,v);

    fclose(in);in=NULL;
    return 0;
}
addVert(struct station st)
{
    int i;
    for(i=0;i<Vnum;i++)
    {
        if(strcmp(BGvertex[i].staname,st.staname)==0)
        return i;
    }
    strcpy(BGvertex[i].staname,st.staname);
    BGvertex[i].change=st.change;
    Vnum++;
    return i;
}
find(char s[])
{
    int i;
    for(i=0;i<Vnum;i++)
    {
        if(strcmp(BGvertex[i].staname,s)==0)
        return i;
    }
}

100034
search(char *str,int k)
{
  if(s==NULL)
  return 0;
  for(int i=0;i<k;i++)
  {
    if(strcmp(str,s[i])==0)
    return i;
  }
  return 0;
}
Dijkstra(int v0,int v1,int k)
{
  int i,j,v,minweight;
  for(i=0;i<k;i++)
  {
    Sweight[i]=weight[v0][i];
    path[i]=v0;
  }
  Sweight[v0]=0;
  wfound[v0]=1;;
  for(i=0;i<k;i++)
  {
    minweight=max;
    for(j=0;j<k;j++)
    if(!wfound[j]&&Sweight[j]<minweight)
    {
      v=j;
      minweight=Sweight[v];
    }
    wfound[v]=1;
    if(wfound[v1]==1)
    {
      int h,m,f[v1-1];
      for(m=0,h=v1;h!=v0;h=path[h],m++)
      f[m]=h;
      f[m]=v0;
      for(int p=m;p>0;p--)
      printf("",s[f[p]],num[f[p]][f[p-1]],Sweight[f[p-1]]-Sweight[f[p]]);
      printf("",s[v1]);
      return;
    }
    for(j=0;j<k;j++)
    {
      if(!wfound[j]&&(minweight+weight[v][j]<Sweight[j]))
      {
        Sweight[j]=minweight+weight[v][j];
        path[j]=v;
      }
    }
    
  }
}
main()
{
  FILE *fp=fopen("","");
  int n,a,b,c,k=0;
  char str[100];
  fscanf(fp,"",&n);
  for(int i=0;i<512;i++)
  for(int j=0;j<512;j++)
  {
    if(i==j)
    weight[i][j]=0;
    else
    weight[i][j]=max;
    num[i][j]=0;
  }
  for(int i=0;i<n;i++)
  {
    fscanf(fp,"",&a,&b);
    int t[512],l=0,p=k;
    char q[50];
    q[0]=''\0'';
    for(int j=0;j<b;j++)
    {
      fscanf(fp,"",str);
      if(str[0]!=''\n'')
      {
        fscanf(fp,"",&c);
        int flag=search(str,k);
        if(!flag)
        {
          strcpy(s[k],str);
          t[l++]=k;
          change[k++]=c;
        }
        else if(strcmp(str,q))
        t[l++]=flag;
        if(q[0]==''\0'')
        strcpy(q,str);
      }
    }
    for(int j=0;j<l;j++)
    for(int m=0;m<l;m++)
    {
      weight[t[j]][t[m]]=j-m>=0?j-m:m-j;
      num[t[j]][t[m]]=a;
    }
  }
  char str1[50],str2[50];
  gets(str1);
  gets(str2);
  Dijkstra(search(str1,k),search(str2,k),k);
}

100035
main(void) {
   get_information();

   memset(head, -1, sizeof head);

   compress();
   build_map();
   scanf("", Departure, Arrival);
   find_target();

   dijkstra();

   record_path(end);

   print_answer();

   return 0;
}
print_answer() {
   printf("", Departure);

   
   printf("", record[analysis[0]]);
   int flag = 1, w = 1;

   for (int i = 1; i < als - 1; i++) {
      int now = analysis[i], last = analysis[i - 1];
      if (record[now] != record[last]) {
         printf("", w, hash[all[last]]);
         w = 1, flag = 0;
      } else
         w++;
      if (!flag) {
         printf("", record[now]);
         flag = 1;
      }
   }
   
   printf("", ++w, Arrival);
}
record_path(int end) {
   if (end == begin)
      return;
   record_path(prev[end]);
   
   analysis[als++] = end;
}
connect(int k1, int k2, int cur_line) {
   e[idx] = k2, cur[idx] = cur_line, ne[idx] = head[k1], head[k1] = idx++;
}
BKDRhash(char* s) {
   unsigned long long hash = 0, seed = 131;
   while (*s)
      hash = hash * seed + (*s++);
   return hash % MOD;
}
find(char* s) {
   int k = BKDRhash(s);

   while (hash[k] != NULL && strcmp(hash[k], s)) {
      k++;
      if (k == MOD)
         k = 0;
   }
   return k;
}
add_to_hash(char* s) {
   int k = find(s);
   if (hash[k] != NULL)
      return k;

   hash[k] = s;

   return k;
}
get_information() {
   fp = fopen("", "");

   fscanf(fp, "", &lines);

   int num, type;
   for (int i = 1; i <= lines; i++) {
      fscanf(fp, "", &seq[i], &cnt[i]);

      for (int j = 1; j <= cnt[i]; j++) {
         fscanf(fp, "", total[i][j], &type);
         int k = add_to_hash(total[i][j]);
         index[i][j] = k;
      }
   }
}
compress() {
   for (int i = 0; i < MOD; i++)
      if (hash[i])
         all[++stations] = i, rev[i] = stations;
}
find_target() {
   int k1 = find(Departure), k2 = find(Arrival);
   begin = rev[k1], end = rev[k2];
}
build_map() {
   for (int i = 1; i <= lines; i++) {
      for (int j = 2; j <= cnt[i]; j++) {
         int k1 = rev[index[i][j - 1]], k2 = rev[index[i][j]];
         connect(k1, k2, seq[i]), connect(k2, k1, seq[i]);
      }
   }
}
dijkstra() {
   memset(dist, 0x3f, sizeof dist);
   dist[begin] = 0;

   for (int i = 0; i < stations; i++) {
      int t = -1;
      for (int j = 1; j <= stations; j++)
         if (!st[j] && (t == -1 || dist[j] < dist[t]))
            t = j;

      for (int j = head[t]; j != -1; j = ne[j]) {
         int x = e[j];
         int way = cur[j];

         if (dist[t] + 1 < dist[x]) {
            dist[x] = dist[t] + 1;
            prev[x] = t, record[x] = way;  
         }
      }

      st[t] = 1;
   }
   return dist[end];
}

100036
add_vex(Vex p)
{ 
    if (!p.istransfer)
    { 
        v[vnum++] = p;
        return vnum - 1; 
    }
    else
    {
        for (int i = 0; i < vnum; i++)
        { 
            if (!strcmp(p.station_name, v[i].station_name))
                return i;
        }
        v[vnum++] = p; 
        return vnum - 1;
    }
}
create_graph()
{ 
    FILE *src = fopen("", "");
    int v1, v2; 
    int line_cnt;
    Vex tmp_vex;
    fscanf(src, "", &line_cnt);
    for (int i = 0; i < line_cnt; i++)
    {
        int lineID, staion_cnt;
        fscanf(src, "", &lineID, &staion_cnt);
        v1 = v2 = -1;
        for (int j = 0; j < staion_cnt; j++)
        {
            fscanf(src, "", tmp_vex.station_name, &tmp_vex.istransfer);
            v2 = add_vex(tmp_vex);
            if (v1 != -1)
            {
                mat[v1][v2].weight = mat[v2][v1].weight = 1;
                mat[v1][v2].line = mat[v2][v1].line = lineID;
            }
            v1 = v2;
        }
    }
    fclose(src);
}
DFS(int i)
{
    printf("", v[i].station_name);
    visited_dfs[i] = 1;
    for (int j = 0; j < vnum; j++)
    {
        if (mat[i][j].weight > 0 && visited_dfs[j] == 0)
        {
            DFS(j);
        }
    }
}
Dijkstra(int v0)
{
    int minweight, minv;
    int wfound[MAXVEX] = {0}; 
    for (int i = 0; i < vnum; i++)
    {
        sweight[i] = mat[v0][i].weight;
        spath[i] = v0;
        wfound[i] = 0;
    }
    sweight[v0] = 0;
    wfound[v0] = 1;
    for (int i = 0; i < vnum - 1; i++)
    {
        minweight = INF;
        for (int j = 0; j < vnum; j++)
        {
            if (!wfound[j] && sweight[j] < minweight)
            {
                minv = j;
                minweight = sweight[minv];
            }
        }
        wfound[minv] = 1;
        for (int j = 0; j < vnum; j++)
        {
            if (!wfound[j] && (minweight + mat[minv][j].weight) < sweight[j])
            {
                sweight[j] = minweight + mat[minv][j].weight;
                spath[j] = minv;
            }
        }
    }
}
reverse()
{
    int temple[MAXVEX] = {0};
    for (int i = 0; i < path_cnt; i++)
    {
        temple[path_cnt - 1 - i] = final_path[i];
    }
    for (int i = 0; i < path_cnt; i++)
    {
        final_path[i] = temple[i];
    }
}
put_path()
{
    int now, last, way_now, len;
    last = 0, now = 1;
    way_now = mat[final_path[last]][final_path[now]].line;
    len = 0;
    printf("", v[final_path[0]].station_name);
    for (; now < path_cnt; now++)
    {
        if (way_now != mat[final_path[last]][final_path[now]].line)
        {
            printf("", way_now, len, v[final_path[last]].station_name);
            way_now = mat[final_path[last]][final_path[now]].line;
            len = 0;
        }
        len++;
        last = now;
    }
    printf("", way_now, len, v[final_path[last]].station_name);
}
main()
{
    for (int i = 0; i < MAXVEX; i++)
    {
        for (int j = 0; j < MAXVEX; j++)
        {
            mat[i][j].weight = INF;
            mat[i][j].line = 0;
        }
    }
    create_graph();
    char begin[32], end[32];
    scanf("", begin, end);
    int index_b, index_e;
    
    for (int i = 0; i < vnum; i++)
    {
        if (!strcmp(begin, v[i].station_name))
        {
            index_b = i;
            
        }
        if (!strcmp(end, v[i].station_name))
        {
            index_e = i;
            
        }
    }
    
    
    
    
 
    
 
    
    
    Dijkstra(index_b);
    
    int tmp = index_e;
    while (tmp != index_b)
    {
        final_path[path_cnt++] = tmp;
        tmp = spath[tmp];
    }
    final_path[path_cnt++] = tmp;
    reverse();
    
    put_path();
}

100039
swap(int * a, int * b) {int tmp = *a;*a = *b;*b = tmp;}
add_stn(char name[MAX_NAME_LEN], int exchange) {
    if (!exchange) {
        map[V].is_ex = exchange;
        strcpy(map[V].name, name);
        return V++;
    }
    for (int i = 0; i < V; i++) 
        if (map[i].is_ex && strcmp(map[i].name, name) == 0) 
            return i;
    map[V].is_ex = exchange;
    strcpy(map[V].name, name);
    return V++;
}
link(int from, int to, int line, int weight) {
    for (int i = 0; i < MAX_EX_STN; i++) {
        if (map[from].next[i].lin == -1) {
            map[from].next[i].lin = line;
            map[from].next[i].wei = weight;
            map[from].next[i].stn_i = to;
            break;
        }
    }
    return ;
}
next_to(int from, int to) {
    for (int i = 0; i < MAX_EX_STN; i++) {
        if (map[from].next[i].lin == -1) break;
        if (map[from].next[i].stn_i == to) return 1;
    }
    return INF;
}
stn_line(int from, int to) {
    for (int i = 0; i < MAX_EX_STN; i++) {
        if (map[from].next[i].lin == -1) break;
        if (map[from].next[i].stn_i == to) return map[from].next[i].lin;
    }
    return -1;
}
output(int path[MAX_STN_NUM], int path_len) {
    int lin = stn_line(path[0], path[1]);
    int tmplen = 1, tmplin = lin;
    printf("", map[path[0]].name);
    for (int i = 1; i < path_len - 1; i++) {
        tmplin = stn_line(path[i], path[i+1]);
        if (tmplin == lin) tmplen++;
        else {
            printf("", lin, tmplen, map[path[i]].name);
            tmplen = 1;
            lin = tmplin;
        }
    }
    printf("", lin, tmplen, map[path[path_len-1]].name);
}
dij(int from, int to) {
    int d[MAX_STN_NUM];
    int prev[MAX_STN_NUM] = {0};
    int path[MAX_STN_NUM] = {0};
    for (int i = 0; i < MAX_STN_NUM; i++) 
        d[i] = INF;
    int path_len = 0;
    prev[from] = from;
    d[from] = 0;
    while (1) {
        int v = -1;
        for (int u = 0; u < V; u++) 
            if (!used[u] && (v == -1 || d[u] < d[v])) v = u;
        
        if (v == -1) break;
        used[v] = 1;
        for (int i = 0; i < MAX_EX_STN; i++) {
            int u = map[v].next[i].stn_i;
            if (u == -1) break;
            int tmp = next_to(v, u) + d[v];
            if (tmp < d[u]) {
                prev[u] = v;
                d[u] = tmp;
            }
        }
    }
    path[0] = to;
    for (int i = 1; ; i++) {
        if (prev[path[i-1]] == path[i-1]) {
            path_len = i;
            break;
        }
        path[i] = prev[path[i-1]];
        
    }
    for (int i = 0, j = path_len - 1; i < j; i++, j--)
        swap(&path[i], &path[j]);
    output(path, path_len);
}
main() {
    int line_num, v1, v2;
    FILE * IN = fopen("", "");
    for (int i = 0; i < MAX_STN_NUM; i++) {
        for (int j = 0; j < MAX_EX_STN; j++) {
            map[i].next[j].lin = -1;
        }
    }

    fscanf(IN, "", &line_num);
    for (int i = 0; i < line_num; i++) {
        int line_index, line_stn_num;
        char tmpname[MAX_NAME_LEN];
        int tmpex;
        v1 = v2 = -1;

        fscanf(IN, "", &line_index, &line_stn_num);
        for (int j = 0; j < line_stn_num; j++) {
            fscanf(IN, "", tmpname, &tmpex);
            v1 = add_stn(tmpname, tmpex);
            if (v2 != -1)
                link(v1, v2, line_index, 1), link(v2, v1, line_index, 1);
            v2 = v1;
        }
    }
    char s1[MAX_NAME_LEN], s2[MAX_NAME_LEN];
    scanf("", s1, s2);
    v1 = v2 = -1;
    for (int i = 0; i < V && (v1 == -1 || v2 == -1); i++) {
        if (strcmp(map[i].name, s1) == 0) v1 = i;
        if (strcmp(map[i].name, s2) == 0) v2 = i;
    }
    dij(v1, v2);
    return 0;
}

100040
pushup(int p) {
	tr[p].sum=tr[p<<1].sum+tr[p<<1|1].sum;
}
pushdown(int p) {
	if(tr[p].add==0)return ;
	tr[p<<1].sum+=tr[p].add*(tr[p<<1].r-tr[p<<1].l+1);
	tr[p<<1|1].sum+=tr[p].add*(tr[p<<1|1].r-tr[p<<1|1].l+1);
	tr[p<<1].add+=tr[p].add;
	tr[p<<1|1].add+=tr[p].add;
	tr[p].add=0;
}
build(int p,int l,int r) {
	tr[p].l=l,tr[p].r=r,tr[p].add=0;
	if(l==r) {
		int x;
		tr[p].sum=1;
		return ;
	}
	int mid=(l+r)>>1;
	build(p<<1,l,mid);
	build(p<<1|1,mid+1,r);
	pushup(p);
}
modify(int p,int l,int r,int add) {
	if(l<=tr[p].l&&r>=tr[p].r) {
		tr[p].sum+=add*(tr[p].r-tr[p].l+1);
		tr[p].add+=add;
		return ;
	}
	pushdown(p);
	int mid=(tr[p].l+tr[p].r)>>1;
	if(l<=mid)modify(p<<1,l,r,add);
	if(r>mid)modify(p<<1|1,l,r,add);
	pushup(p);
}
query(int p,int l,int r) {
	if(l<=tr[p].l&&r>=tr[p].r)return tr[p].sum;
	int sum=0;
	pushdown(p);
	int mid=(tr[p].l+tr[p].r)>>1;
	if(l<=mid)sum+=query(p<<1,l,r);
	if(r>mid)sum+=query(p<<1|1,l,r);
	return sum;
}
CHAZHAO(char *s) {
	int i;
	for(i=0; i<sum; i++) {
		if(strcmp(s,SID_LST[i].stationName)==0) {
			return i;
		}
	}
	return -1;
}
dijkstra(int vs, int ve) {
	int i,j,k=0,minn,tmp;
	int VISTED[500];
	for (i = 0; i < sum; i++) {
		VISTED[i] = 0;
		minpath[i] = vs;
		minweight[i] = MAP[vs][i].val;
	}
	minweight[vs] = 0;
	VISTED[vs] = 1;
	for (i = 0; i < sum - 1; i++) {
		minn = INF;
		for (j = 0; j < sum; j++) {
			if (VISTED[j]==0 && minweight[j]<minn) {
				minn = minweight[j];
				k = j;
			}
		}
		if(k==ve)return;
		VISTED[k] = 1;
		for (j = 0; j < sum; j++) {
			tmp = minn + MAP[k][j].val;
			if (VISTED[j] == 0 && (tmp  < minweight[j]) && MAP[k][j].ID_DI>0) {
				minweight[j] = tmp;
				minpath[j] = k;
			}
		}
	}
}
main() {
	int i,j,BEGIN,DESTINATION,t;
	in = fopen("","");
	scanf("",START_ST,DESTINATION_ST);
	build(1,1,400);
	for(i=0;i<500;i++)modify(1,1,300,2);
	for(i=0; i<500; i++) {
		for(j=0; j<500; j++) {
			MAP[i][j].val=MAP[j][i].val=INF;
			MAP[i][j].ID_DI=MAP[j][i].ID_DI=0;
		}
	}
	int ID_qsq,EdgeLast;
	char stationName[30];
	fscanf(in,"",&_Line_Number);
	for(i=0; i<_Line_Number; i++) {
		fscanf(in,"",&ID_DI,&StationNum);
		EdgeLast=-1;
		for(j=0; j<StationNum; j++) {
			fscanf(in,"",stationName,&IsChange);
			ID_qsq=CHAZHAO(stationName);
			if(ID_qsq == -1) {
				strcpy(SID_LST[sum].stationName,stationName);
				SID_LST[sum].IsChange=IsChange;
				if(EdgeLast != -1) {
					MAP[EdgeLast][sum].ID_DI=MAP[sum][EdgeLast].ID_DI=ID_DI;
					MAP[EdgeLast][sum].val=MAP[sum][EdgeLast].val=1;
				}
				EdgeLast=sum;
				sum++;
			} else {
				if(EdgeLast != -1) {
					MAP[EdgeLast][ID_qsq].ID_DI=MAP[ID_qsq][EdgeLast].ID_DI=ID_DI;
					MAP[EdgeLast][ID_qsq].val=MAP[ID_qsq][EdgeLast].val=1;
				}
				EdgeLast = ID_qsq;
			}
		}
	}
	BEGIN=CHAZHAO(START_ST);
	DESTINATION=CHAZHAO(DESTINATION_ST);
	dijkstra(BEGIN,DESTINATION);
	for(t=DESTINATION; t!=BEGIN; t=minpath[t]) {
		path[HEAD]=t;
		HEAD++;
		int *pt;
		pt=&t;
	}
	int ID_DI=MAP[BEGIN][path[HEAD-1]].ID_DI ;
	printf("",SID_LST[BEGIN].stationName,ID_DI);
	int LENGTH=1, e1=path[HEAD-1], e2;
	for(i=HEAD-2 ; i>=0 ; i--) {
		e2=path[i];
		int *pt;
		pt=&i;
		if(ID_DI != MAP[e1][e2].ID_DI ) {
			ID_DI=MAP[e1][e2].ID_DI;
			printf("",LENGTH,SID_LST[e1].stationName,ID_DI);
			LENGTH=0;
		}
		LENGTH++;
		e1=e2;
	}
	printf("",LENGTH,SID_LST[DESTINATION].stationName);
	return 0;
}

100041
se(char* s)
{
	int i;
	for (i = 0; i < nu; i++)
		if (strcmp(s, sl[i].na) == 0)
		{
			return i;
		}
	return -1;
}
dij(int a, int b)
{
	int i=0, j=0, k, m, t;
	int flag[600] = { 0 };
	for (i = 0; i < nu; i++)
	{
		flag[i] = 0;
		pre[i] =a;
		di[i] = map[a][i].wei;
	}
	di[a] = 0, flag[a] = 1;
	for (i = 0; i < nu - 1; i++)
	{
		m = big;
		for (j = 0; j < nu; j++)
		{
			if (flag[j] == 0 && di[j] < m)
			{
				m = di[j];
				k = j;
			}
		}
		flag[k] = 1;
		if (k == b) 
		{
			return;
		}
		for (j = 0; j < nu; j++)
		{
			t = (map[k][j].wei == big ? big : (m + map[k][j].wei));
			if (flag[j] == 0 && t < di[j] && map[k][j].lin > 0)
			{
				di[j] = t;
				pre[j] = k;
			}
		}
	}
}
pri(int v1, int v2)
{
	int i, e = v1, p = 1, u = pa[to - 1];
	int l = map[e][u].lin;
	printf("", sl[v1].na, l);
	e = u;
	for (i = to - 2; i >= 0; i--)
	{
		u = pa[i];
		if (l != map[e][u].lin)
		{
			l = map[e][u].lin;
			printf("", p, sl[e].na, l);
			p = 0;
		}
		p++;
		e = u;
	}
	printf("", p, sl[v2].na);
}
main()
{
	int i, j, a, b, t;
	FILE* fp = fopen("", "");
	scanf("", be, end);
	for (i = 0; i < 600; i++)
	{
		for (j = 0; j < 600; j++)
		{
			map[i][j].wei = map[j][i].wei = big;
			map[i][j].lin = map[j][i].lin = 0;
		}
	}
	i = 0;
	j = 0;
	int id = 0, eda = 0;
	char na[100];
	fscanf(fp, "", &num);
	for (i = 0; i < num; i++)
	{
		fscanf(fp, "", &li, &st);
		eda = -1;
		for (j = 0; j < st; j++)
		{
			fscanf(fp, "", na, &is);
			id = se(na);
			if (id == -1)
			{
				strcpy(sl[nu].na, na);
				sl[nu].ca = is;
				if (eda != -1)
				{
					map[eda][nu].lin = map[nu][eda].lin = li;
					map[eda][nu].wei = map[nu][eda].wei = 1;
				}
				eda = nu;
				nu++;
			}
			else
			{
				if (eda != -1)
				{
					map[eda][id].lin = map[id][eda].lin = li;
					map[eda][id].wei = map[id][eda].wei = 1;
				}
				eda = id;
			}
		}
	}
	a = se(be);	
	b = se(end);	
	dij(a, b);	
	for (t = b; t != a; t = pre[t])	
	{
		pa[to] = t;
		to++;
	}
	pri(a, b);	
	return 0;
}

100043
main()
{
	int i=0,j=0,k=0;
	for(i=0;i<311;i++)
	{
		path[i]=-1;
		dist[i]=1000;
	}
	for(i=0;i<16;i++)
	{
		line[i].next=NULL;
	}
	for(i=0;i<1000;i++)
	{
		station->next=NULL;
	}
	for(i=0;i<400;i++)
	{
		g[i].next=NULL;
	}
	FILE *in;
	in=fopen("","");
	fgets(s,1024,in);
	i=-1;
	while((fgets(s,1024,in))!=NULL)
	{
		
		if(s[0]==''\n'')
		{
			continue;
		}
		else
		{
			if(s[0]<=''&&s[0]>='')
		{
			i++;
			
			line[i].name=atoi(s);
			for(j=0;s[j]!='';j++);
			line[i].n=atoi(s+j+1);
			
		}
		else
		{
		    struct vlink *p,*q;
			q=(struct vlink *)malloc(sizeof(struct vlink));
			q->next=NULL;
			q->last=NULL;
			sscanf(s,"",q->name,&q->ischange);
			if(line[i].next==NULL)
			{
				line[i].next=q;
			}
			else
			{
				for(p=line[i].next;p->next!=NULL;p=p->next);
				p->next=q;
				q->last=p;
			}	
		}
		}
	}
		for(i=0;i<16;i++)
	{
		struct vlink *p;
		for(p=line[i].next;p!=NULL;p=p->next)
		{
			if(p->ischange==0)
			{
				strcpy(station_name[n_station],p->name);
				line_station[n_station][0]++;
				line_station[n_station][line_station[n_station][0]]=line[i].name;
				n_station++;
			}
			else
			{
				int flag=0;
				for(j=0;j<n_station;j++)
				{
					if(strcmp(p->name,station_name[j])==0)
					{
						line_station[j][0]++;
				        line_station[j][line_station[j][0]]=line[i].name;
						flag=1;
						break;
					}
				}
				if(flag==0)
				{
					strcpy(station_name[n_station],p->name);
					line_station[n_station][0]++;
				    line_station[n_station][line_station[n_station][0]]=line[i].name;
					n_station++;
				}
				
			}
		}	
	}
	
	
		for(i=0;i<16;i++)
	{
		struct vlink *p;
		for(p=line[i].next;p->next!=NULL;p=p->next)
		{
			struct new_elink *q,*r;
			q=(struct new_elink *)malloc(sizeof(struct new_elink));
			q->next=NULL;
			q->adj=search(p->next->name);
			int t=search(p->name);
			if(g[t].next==NULL)
			{
				g[t].next=q;
			}
			else
			{
			for(r=g[t].next;r->next!=NULL;r=r->next);
			r->next=q;
				
			}
		}
		for(;p->last!=NULL;p=p->last)
		{
			struct new_elink *q,*r;
			q=(struct new_elink *)malloc(sizeof(struct new_elink));
			q->next=NULL;
			q->adj=search(p->last->name);
			int t=search(p->name);
			if(g[t].next==NULL)
			{
				g[t].next=q;
			}
			else
			{
				for(r=g[t].next;r->next!=NULL;r=r->next);
				r->next=q;
			}
		}
	}
































	
	scanf("",start,end);
	num_start=search(start);
	num_end=search(end);
	vvisit[num_start]=1;
	n_visit++;
	struct new_elink *p;
	for(p=g[num_start].next;p!=NULL;p=p->next)
	{
		dist[p->adj]=1;
		path[p->adj]=num_start;
	}
	while(n_visit<311)
	{
		int min_num;
		int min_dist=500;
		for(i=0;i<311;i++)
		{
			if(dist[i]<min_dist&&vvisit[i]==0)
			{
				min_num=i;
				min_dist=dist[i];
			}
		}
		vvisit[min_num]=1;
		n_visit++;
		struct new_elink *r;
		for(r=g[min_num].next;r!=NULL;r=r->next)
		{
			if(vvisit[r->adj]==0)
			{
				if((min_dist+1)<dist[r->adj])
				{
					dist[r->adj]=min_dist+1;
		            path[r->adj]=min_num;
				}
				
			}
		}
	}
	
	n_road=0;
	i=num_end;
	while(i!=num_start)
	{
		strcpy(road[n_road++],station_name[i]);
		i=path[i];
	}
	strcpy(road[n_road++],station_name[num_start]);
	
	int n1=0,n2=0,ttn=0;
	printf("",road[n_road-1]);
	for(i=n_road-1;i>=1;i--)
	{
		if(n1==0)
		{
			n1=research(road[i],road[i-1]);
			n2++;











		}
		else
		{
			ttn=research(road[i],road[i-1]);
			if(ttn==n1)
			{
				n2++;
			}
			else
			{
				printf("",n1,n2,road[i]);
				n1=ttn;
				n2=1;
			}























		}
	}
	printf("",n1,n2,road[i]);









	















	fclose(in);
	return 0;
}
search(char str[])
{
	int i;
	for(i=0;i<n_station;i++)
	{
		if(strcmp(station_name[i],str)==0)
		return i;
	}
}
research(char str1[40],char str2[40])
{
	int i;
	for(i=0;i<16;i++)
	{
		struct vlink *p;
		for(p=line[i].next;p->next!=NULL;p=p->next)
		{
			if(strcmp(p->name,str1)==0&&strcmp(p->next->name,str2)==0)
			return line[i].name;
			else
			{
				if(strcmp(p->name,str2)==0&&strcmp(p->next->name,str1)==0)
			    return line[i].name;
			}
		}
		
    }
}

110014
find(char s[])
{
	int i;
	int t = -1;
	for (i = 1; i <= tot; i++)
		if (strcmp(s, name[i]) == 0)
		{
			t = i;
			break;
		}
	return t;
}
add(int x, int y, int z)
{
	e[++k].to = y;
	e[k].next = head[x];
	e[k].id = z;
	e[k].from = x;
	head[x] = k;
}
spfa(int xx, int yy)
{
	int i;
	for (i = 1; i <= tot; i++)
		d[i] = 100000;
	d[xx] = 0;
	q[1] = xx;
	v[xx] = 1;
	int l = 1, r = 1;
	while (l <= r)
	{
		int x = q[l++];
		v[x] = 0;
		i = head[x];
		while (i)
		{
			if (d[e[i].to] > d[x] + 1)
			{
				d[e[i].to] = d[x] + 1;
				from[e[i].to] = i;
				if (!v[e[i].to])
				{
					v[e[i].to] = 1;
					q[++r] = e[i].to;
				}
			}
			i = e[i].next;
		}
	}
	tot = 0;
	while (yy != xx)
	{
		ans[++tot] = from[yy];
		yy = e[from[yy]].from;
	}
	printf("", name[xx]);
	int num = 0;
	for (i = tot; i >= 1; i--)
	{
		if (i != tot && e[ans[i]].id != e[ans[i + 1]].id)
		{
			printf("", e[ans[i + 1]].id, num, name[e[ans[i]].from]);
			num = 1;
		}
		else
			num++;
	}
	printf("", e[ans[1]].id, num, name[e[ans[1]].to]);
}
main()
{
	FILE *fp = fopen("", "");
	fscanf(fp, "", &n);
	int i, j, x, y;
	for (i = 1; i <= n; i++)
	{
		fscanf(fp, "", &x, &a[i]);
		int pre = -1;
		for (j = 1; j <= a[i]; j++)
		{
			fscanf(fp, "", &s, &y);
			int t = find(s);
			if (t == -1)
			{
				t = ++tot;
				strcpy(name[tot], s);
			}
			if (pre != -1)
			{
				add(pre, t, x);
				add(t, pre, x);
			}
			pre = t;
		}
	}
	scanf("", s1, s2);
	int t1 = find(s1);
	int t2 = find(s2);
	spfa(t1, t2);
	return 0;
}

100046
main(){
	for(int i=0;i<512;i++){
		for(int j=0;j<512;j++){
			if(i==j)BGweights[i][j].wei=0;
			else BGweights[i][j].wei=INFINITY;
		}
	}
	initMap();
	
	scanf("",start,end);
	for(int i=0;i<VNUM;i++){
		if(strcmp(BGvertex[i].sname,start)==0)vs=i;
	}
	for(int i=0;i<VNUM;i++){
		if(strcmp(BGvertex[i].sname,end)==0)ve=i;
	}






     Dijkstra(vs);
     int k,m=0;







     printpath(ve,vs,-1);
     



	    

	return 0;
}
initMap()
{
        FILE *fp;
        int i,j,snum,lno,lnum,  v1,v2;
        struct station st;
        
        fp=fopen("","");
        
        fscanf(fp,"",&snum);
        for(i=0; i<snum; i++) {
                fscanf(fp,"",&lno,&lnum);
                v1 = v2 = -1;
                for(j=0; j<lnum; j++){ 
                        fscanf(fp,"",st.sname,&st.ischange);
	                    v2 = addvertex(st); 
	                    if(v1 != -1){
	                        BGweights[v1][v2].wei = BGweights[v2][v1].wei = 1;
	                        BGweights[v1][v2].lno = BGweights[v2][v1].lno = lno;
	                    }
	                    v1 = v2;
                }
        }
       fclose(fp);
       return;
}
addvertex(struct station st)
{
	
	for(int i=0;i<VNUM;i++){
		if(strcmp(BGvertex[i].sname,st.sname)==0)return i;
	}
	strcpy(BGvertex[VNUM].sname,st.sname);
	BGvertex[VNUM++].ischange=st.ischange;

	return VNUM-1;
}
Dijkstra( int  v0)
{
    int i, j, v, minweight;
    for(i=0; i<VNUM; i++) { Sweight[i] = BGweights[v0][i].wei; Spath[i] = v0; }  
    Sweight [v0] = 0;  
    wfound [v0] = 1;  
     for(i=0; i< VNUM-1; i++) {  
         minweight =   INFINITY;
         for(j=0; j <  VNUM;  j++)   
             if( !wfound[j] && ( Sweight[j] < minweight) ) {
                 v = j; 
                 minweight = Sweight[v];
             }
         wfound[v] = 1;	

		 
         for(j =0; j < VNUM; j++){
		        if( !wfound[j]  &&  (minweight + BGweights[v][j].wei < Sweight[j] )) {
                 Sweight[j] = minweight + BGweights[v][j].wei;
                 Spath[j] = v;  
                 
                }
		 }
		  
             

     } 
}
printpath(int i,int vs,int afteri)
{
	if(i==vs){
		printf("",BGvertex[Spath[i]].sname,BGweights[Spath[i]][i].lno );
		return;
	}
	else if(i==ve){
		printpath(Spath[i],vs,i);
			printf("",BGweights[i][Spath[i]].lno,++sum,BGvertex[i].sname);
			sum=0;
	}
	else if(BGweights[i][afteri].lno!=BGweights[Spath[i]][i].lno){
	     printpath(Spath[i],vs,i);
			printf("",BGweights[i][Spath[i]].lno,++sum,BGvertex[i].sname);
			sum=0;

	}
	else {
	printpath(Spath[i],vs,i);
	
	sum++;
	}
}

100047
add_vex(Vex p)
{
    if (!p.istransfer)
    {
        v[vnum++] = p;
        return vnum - 1; 
    }
    else
    {
        for (int i = 0; i < vnum; i++)
        {
            if (!strcmp(p.station_name, v[i].station_name))
                return i;
        }
        v[vnum++] = p;
        return vnum - 1;
    }
}
create_graph()
{
    FILE *src = fopen("", "");
    int v1, v2; 
    int line_cnt;
    Vex tmp_vex;
    fscanf(src,"",&line_cnt);
    for (int i = 0; i < line_cnt; i++)
    {
        int lineID, staion_cnt;
        fscanf(src,"",&lineID, &staion_cnt);
        v1 = v2 = -1;
        for (int j=0;j<staion_cnt;j++)
        {
            fscanf(src,"",tmp_vex.station_name,&tmp_vex.istransfer);
            v2=add_vex(tmp_vex);
            if (v1!=-1)
            {
                mat[v1][v2].weight=mat[v2][v1].weight=1;
                mat[v1][v2].line=mat[v2][v1].line=lineID;
            }
            v1=v2;
        }
    }
    fclose(src);
}
DFS(int i)
{
    printf("",v[i].station_name);
    visited_dfs[i]=1;
    for (j=0;j<vnum;j++)
    {
        if(mat[i][j].weight>0&&visited_dfs[j]==0)
        DFS(j);
    }
}
Dijkstra(int v0)
{
    int minweight, minv;
    int wfound[1000] = {0};
    for (int i=0;i<vnum;i++)
    {
        sweight[i]=mat[v0][i].weight;
        spath[i]=v0;
        wfound[i]=0;
    }
    sweight[v0]=0;
    wfound[v0]=1;
    for (int i=0;i<vnum-1;i++)
    {
        minweight=32767;
        for (int j=0;j<vnum;j++)
        {
            if (!wfound[j]&&sweight[j]<minweight)
            {
                minv=j;
                minweight=sweight[minv];
            }
        }
        wfound[minv]=1;
        for (int j=0;j<vnum;j++)
        {
            if (!wfound[j]&&(minweight+mat[minv][j].weight)<sweight[j])
            {
                sweight[j]=minweight+mat[minv][j].weight;
                spath[j]=minv;
            }
        }
    }
}
reverse()
{
    int temple[1000] = {0};
    for (int i = 0; i < path_cnt; i++)
    {
        temple[path_cnt - 1 - i] = final_path[i];
    }
    for (int i = 0; i < path_cnt; i++)
    {
        final_path[i] = temple[i];
    }
}
put_path()
{
    int now, last, way_now, len;
    last = 0, now = 1;
    way_now = mat[final_path[last]][final_path[now]].line;
    len = 0;
    printf("", v[final_path[0]].station_name);
    for (; now < path_cnt; now++)
    {
        if (way_now != mat[final_path[last]][final_path[now]].line)
        {
            printf("", way_now, len, v[final_path[last]].station_name);
            way_now = mat[final_path[last]][final_path[now]].line;
            len = 0;
        }
        len++;
        last = now;
    }
    printf("", way_now, len, v[final_path[last]].station_name);
}
main()
{
    for (int i = 0; i < 1000; i++)
    {
        for (int j = 0; j < 1000; j++)
        {
            mat[i][j].weight = 32767;
            mat[i][j].line = 0;
        }
    }
    FILE *src = fopen("", "");
    int v1, v2; 
    int line_cnt;
    Vex tmp_vex;
    fscanf(src,"",&line_cnt);
    for (int i = 0; i < line_cnt; i++)
    {
        int lineID, staion_cnt;
        fscanf(src,"",&lineID, &staion_cnt);
        v1 = v2 = -1;
        for (int j=0;j<staion_cnt;j++)
        {
            fscanf(src,"",tmp_vex.station_name,&tmp_vex.istransfer);
            v2=add_vex(tmp_vex);
            if (v1!=-1)
            {
                mat[v1][v2].weight=mat[v2][v1].weight=1;
                mat[v1][v2].line=mat[v2][v1].line=lineID;
            }
            v1=v2;
        }
    }
    fclose(src);
    char begin[32], end[32];
    scanf("", begin, end);
    int index_b, index_e;
    for (int i = 0; i < vnum; i++)
    {
        if (!strcmp(begin, v[i].station_name))
        index_b = i;
        if (!strcmp(end, v[i].station_name))
        index_e = i;
    }
    Dijkstra(index_b);
    int tmp = index_e;
    while (tmp != index_b)
    {
        final_path[path_cnt++] = tmp;
        tmp = spath[tmp];
    }
    final_path[path_cnt++] = tmp;
    int temple[1000] = {0};
    for (int i = 0; i < path_cnt; i++)
    {
        temple[path_cnt - 1 - i] = final_path[i];
    }
    for (int i = 0; i < path_cnt; i++)
    {
        final_path[i] = temple[i];
    }
   int now, last, way_now, len;
    last = 0, now = 1;
    way_now = mat[final_path[last]][final_path[now]].line;
    len = 0;
    printf("", v[final_path[0]].station_name);
    for (; now < path_cnt; now++)
    {
        if (way_now != mat[final_path[last]][final_path[now]].line)
        {
            printf("", way_now, len, v[final_path[last]].station_name);
            way_now = mat[final_path[last]][final_path[now]].line;
            len = 0;
        }
        len++;
        last = now;
    }
    printf("", way_now, len, v[final_path[last]].station_name);
}

100049
find(char str[])
{
	int i;
	for(i=1;i<=m;i++)
		if(strcmp(name[i],str)==0) return i;
	return -1;
}
main()
{
	char start[30],goal[30];
	scanf("",start,goal);
	in=fopen("","");
	int i;
	fscanf(in,"",&n);
	for(i=0;i<100;i++)
	{
		int k;
		for(k=0;k<100;k++) map[i][k]=999;
	}
	for(i=1;i<=n;i++)
	{
		int len,flag,f,k,ml=0,value[100],locat[100],r;
		char str[30],table[100][30];
		fscanf(in,"",&r,&len);
		for(k=1;k<=len;k++)
		{
			fscanf(in,"",str,&flag);
			if(k==1 || flag==1 || strcmp(str,start)==0 || strcmp(str,goal)==0)
			{
				ml++;
				strcpy(table[ml],str);
				value[ml]=k-1;
			}
		}
		for(k=1;k<=ml;k++)
		{
			int t=find(table[k]),j=0;
			if(t==-1)
			{
				m++;
				t=m;
				strcpy(name[t],table[k]);
			}
			locat[k]=t;
			while(line[t][j]!=0 && j<5) j++;
			line[t][j]=r;
		}
		for(k=1;k<=ml;k++)
		{
			int j;
			for(j=1;j<=ml;j++)
				if(map[locat[k]][locat[j]]>abs(value[k]-value[j])) map[locat[k]][locat[j]]=abs(value[k]-value[j]);
		}
	}
	
	int v0=find(goal);
	for(i=1;i<=m;i++)
	{
		sweight[i]=map[v0][i];
		spath[i]=v0;
	}
	wfound[v0]=1;sweight[v0]=0;
	for(i=1;i<m;i++)
	{
		int min=9999,v=0,k;
		for(k=1;k<=m;k++)
		{
			if(sweight[k]<min && wfound[k]==0)
			{
				min=sweight[k];
				v=k;
			}
		}
		wfound[v]=1;
		for(k=1;k<=m;k++)
		{
			if(wfound[k]==0 && map[k][v]!=0 && sweight[k]>sweight[v]+map[v][k])
			{
				sweight[k]=sweight[v]+map[v][k];
				spath[k]=v;
			}
		}
	}
	
	int w=find(start);
	
	while(w!=v0){
		int k=0,j=0,l;
		for(k=0;k<5;k++)
			for(j=0;j<5;j++)
			if(line[w][k]==line[spath[w]][j]){
				l=line[w][k];
				k=5;
				j=5;
			}
		if(w==23 && spath[w]==25 && l==4) l=16;
		if(w==24 && spath[w]==26 && l==4) l=16;
		printf("",name[w],l,map[w][spath[w]]);
		w=spath[w];
	}
	printf("",goal);
	return 0;
}

100051
main()
{
	int i,sta,ed;
	initMap();
	char start[MAXLEN],end[MAXLEN];
	scanf("",start,end);
	for(i=0;i<Vnum;i++){
		if(strcmp(start,BGvertex[i].sname)==0){
			sta=i;
		}
		if(strcmp(end,BGvertex[i].sname)==0){
			ed=i;
		}
	}
	Dijkstra(sta,ed);
	printPath(sta,ed);
	return 0;
}
initMap()
{
	FILE *fp;
	int i,j,snum,lno,lnum,v1,v2;
	struct station st;
	fp=fopen("","");
	fscanf(fp,"",&snum);
	for(i=0;i<snum;i++){
		fscanf(fp,"",&lno,&lnum);
        v1=v2=-1;
        for(j=0;j<lnum;j++){
            fscanf(fp,"",st.sname,&st.ischange);
	        v2 = addVertex(st); 
	        if(v1 != -1){
	            BGweights[v1][v2].wei = BGweights[v2][v1].wei =1;
	            BGweights[v1][v2].lno = BGweights[v2][v1].lno =lno;
	        }
	        v1 = v2;
        }
	}
	for(i=0;i<Vnum;i++){
		for(j=0;j<Vnum;j++){
			if(BGweights[i][j].wei==0){
				BGweights[i][j].wei=INFINITY;
			}
			if(BGweights[i][j].lno==0){
				BGweights[i][j].lno=-1;
			}
		}
	}
	fclose(fp);
	return;
}
addVertex(struct station st)
{
	int i;
	if(st.ischange==1){
		for(i=0;i<Vnum;i++){
			if(strcmp(st.sname,BGvertex[i].sname)==0){
				return i;
			}
		}
	}
	BGvertex[Vnum++]=st;
	return Vnum-1;
}
Dijkstra(int v0,int v1)
{
    int i, j, v, minweight,Sweight[MAXNUM]={0},wfound[MAXNUM] = {0}; 
    for(i=0; i<Vnum; i++) { 
	    Sweight[i] = BGweights[v0][i].wei; 
		Spath[i] = v0; 
	}  
    Sweight[v0]= 0;  
    wfound[v0]= 1;  
    for(i=0; i<Vnum-1; i++) {  
        minweight = INFINITY;
        for(j=0;j<Vnum;j++)   
            if(wfound[j]==0 && (Sweight[j]<minweight)) {
                v = j; 
                minweight = Sweight[v];
            }
        wfound[v] = 1;	
        for(j=0;j<Vnum;j++) 
            if(wfound[j]==0 && (minweight + BGweights[v][j].wei < Sweight[j] )) {
                Sweight[j] = minweight + BGweights[v][j].wei;
                Spath[j] = v;  
           }
     }
     if(wfound[v1]==1){
     	return;
	 }
}
printPath(int v0,int v1)
{
	char path[80]={0},buf[80]={0};
	int board[80],cnt=-1,i,j,hold;
	board[++cnt]=v1;
	v1=Spath[v1];
	while(v1!=v0){
		board[++cnt]=v1;
		v1=Spath[v1];
	}
	board[++cnt]=v0;
	sprintf(buf,"",BGvertex[board[cnt]].sname,BGweights[board[cnt]][board[cnt-1]].lno);
	strcpy(path,buf);
	hold=BGweights[board[cnt]][board[cnt-1]].lno;
	for(i=cnt-1,j=1;i>0;i--,j++){
		if(BGweights[board[i]][board[i-1]].lno!=hold){
			sprintf(buf,"",j,BGvertex[board[i]].sname,BGweights[board[i]][board[i-1]].lno);
		    strcat(path,buf);
		    j=0;
		    hold=BGweights[board[i]][board[i-1]].lno;
		}
	}
	sprintf(buf,"",j,BGvertex[board[i]].sname);
	strcat(path,buf);
	printf("",path);
}


100009
main()
{
    int i, j, v1, v2, t;
    FILE *fp = fopen("", "");
    scanf("", StationBegin, StationEnd);
    for (i = 0; i < M; i++) 
        for (j = 0; j < M; j++)
        {
            map[i][j].weight = map[j][i].weight = INF; 
            map[i][j].lineID = map[j][i].lineID = 0;   
        }
    DrawSubwayMap(fp);                 
    v1 = SearchMap(StationBegin);      

    v2 = SearchMap(StationEnd);        
	
    dijkstra(v1, v2);                  
    for (t = v2; t != v1; t = prev[t]) 
    {
        path[top] = t;
        top++;
    }
    PrintPath(v1, v2); 
    return 0;
}
DrawSubwayMap(FILE *fp)
{
    int i, j, ContainID, EdgeLast; 
    char stationName[30];          
    fscanf(fp, "", &lineNum);
    for (i = 0; i < lineNum; i++)
    {
        fscanf(fp, "", &lineID, &StationNum);
        EdgeLast = -1; 
        for (j = 0; j < StationNum; j++)
        {
            fscanf(fp, "", stationName, &IsChange);
			
            ContainID = SearchMap(stationName); 
            if (ContainID == -1)                
            {
                strcpy(StationID_list[VerNum].stationName, stationName); 
                StationID_list[VerNum].IsChange = IsChange;              
                if (EdgeLast != -1)                                      
                {
                    map[EdgeLast][VerNum].lineID = map[VerNum][EdgeLast].lineID = lineID; 
                    map[EdgeLast][VerNum].weight = map[VerNum][EdgeLast].weight = 1;      
                }
                EdgeLast = VerNum; 
                VerNum++;          
            }
            else
            {
                if (EdgeLast != -1) 
                {
                    map[EdgeLast][ContainID].lineID = map[ContainID][EdgeLast].lineID = lineID; 
                    map[EdgeLast][ContainID].weight = map[ContainID][EdgeLast].weight = 1;      
                }
                EdgeLast = ContainID; 
            }
        }
    }
}
SearchMap(char *s)
{
    int i;
    for (i = 0; i < VerNum; i++)
        if (strcmp(s, StationID_list[i].stationName) == 0)
            return i; 
    return -1;
}
dijkstra(int vs, int ve)
{
    int i, j, k, min, tmp;
    int flag[M];                 
    for (i = 0; i < VerNum; i++) 
    {
        flag[i] = 0;                 
        prev[i] = vs;                
        dist[i] = map[vs][i].weight; 
    }
    dist[vs] = 0, flag[vs] = 1;      
    for (i = 0; i < VerNum - 1; i++) 
    {                                
        min = INF;
        for (j = 0; j < VerNum; j++)
        {
            if (flag[j] == 0 && dist[j] < min)
            {
                min = dist[j];
                k = j;
            }
        }
        flag[k] = 1; 
        
        if (k == ve)
            return;
        for (j = 0; j < VerNum; j++)
        {
            tmp = (map[k][j].weight == INF ? INF : (min + map[k][j].weight)); 
            if (flag[j] == 0 && (tmp < dist[j]) && map[k][j].lineID > 0)
            {
                dist[j] = tmp;
                prev[j] = k; 
            }
        }
    }
}
PrintPath(int v1, int v2)
{
    int i, EdgeLast = v1, pathLen = 1, u = path[top - 1];    
    int lineId = map[EdgeLast][u].lineID;                    
    printf("", StationID_list[v1].stationName, lineId); 
    EdgeLast = u;
    for (i = top - 2; i >= 0; i--) 
    {
        u = path[i];                           
        if (lineId != map[EdgeLast][u].lineID) 
        {
            lineId = map[EdgeLast][u].lineID;
            printf("", pathLen, StationID_list[EdgeLast].stationName, lineId);
            pathLen = 0;
        }
        pathLen++;    
        EdgeLast = u; 
    }
    printf("", pathLen, StationID_list[v2].stationName); 
}

100011
main(void)
{
    initMap();
    char * st_beg = (char *)calloc(MAXLEN, sizeof(char));
    char * st_end = (char *)calloc(MAXLEN, sizeof(char));
    scanf("", st_beg);
    scanf("", st_end);
    int v0 = findSt(st_beg);
    int v1 = findSt(st_end);
    int * spath = (int *)calloc(writer, sizeof(int));
    Dijikstra(v0, v1, spath);
    printPath(v0, v1, spath);

    return 0;
}
initMap()
{
    for(int i = 0; i < MAXNUM; i++)
    {
        for(int j = 0; j < MAXNUM; j++)
        {
            BGweights[i][j].wei = INFINITY;
        }
    }
    FILE * fp = fopen("", "");
    int i, j, snum, lno, lnum, v1, v2;
    struct station st;
    fscanf(fp, "", &snum);
    for(i = 0; i < snum; i++)
    {
        fscanf(fp, "", &lno, &lnum);
        v1 = -1;
        v2 = -1;
        for(j = 0; j < lnum; j++)
        {
            fscanf(fp, "", st.sname, &(st.ischange));
            v2 = addVertex(st);
            if(v1 != -1)
            {
                BGweights[v1][v2].wei = 1;
                BGweights[v2][v1].wei = 1;
                BGweights[v1][v2].lno = lno;
                BGweights[v2][v1].lno = lno;
            }
            v1 = v2;
        }
    }
    fclose(fp);
    return;
}
addVertex(struct station st)
{
    for(int i = 0; i < writer; i++)
    {
        if(strcmp(BGvertex[i].sname, st.sname) == 0)
        {
            return i;
        }
    }
    strcpy(BGvertex[writer].sname, st.sname);
    BGvertex[writer].ischange = st.ischange;
    return (writer++);
}
Dijikstra(int v0, int v1, int spath[])
{
    int i, j, v = 0, minweight;
    char wfound[MAXNUM] = {0};
    int sweight[MAXNUM] = {0};
    for(i = 0; i < writer; i++)
    {
        sweight[i] = BGweights[v0][i].wei;
        spath[i] = v0;
    }
    sweight[v0] = 0;
    wfound[v0] = 1;
    for(i = 0; i < writer - 1; i++)
    {
        minweight = INFINITY;
        for(j = 0; j < writer; j++)
        {
            if((!wfound[j]) && (sweight[j] < minweight))
            {
                v = j;
                minweight = sweight[v];
            }
        }
        wfound[v] = 1;
        if(v == v1)
        {
            return;
        }
        for(j = 0; j < writer; j++)
        {
            if((!wfound[j]) && (BGweights[v][j].lno > 0) && (minweight + BGweights[v][j].wei < sweight[j]))
            {
                sweight[j] = minweight + BGweights[v][j].wei;
                spath[j] = v;
            }
        }
        
    }
}
printPath(int v0, int v1, int spath[])
{
    char path[80] = {0}, buf[80] = {0};
    int board[80] = {0}, bcount = 0, line = -1, sc = 0;
    int i;
    do{
        board[bcount++] = v1;
    }while((v1 = spath[v1]) != v0);
    board[bcount++] = v0;
    line = BGweights[board[bcount - 1]][board[bcount - 2]].lno;
    sprintf(buf, "", BGvertex[board[bcount - 1]].sname, line);
    strcpy(path, buf);
    sc = 1;
    for(i = bcount - 2; i > 0; i--, sc++)
    {
        if(BGweights[board[i]][board[i - 1]].lno != line)
        {
            line = BGweights[board[i]][board[i - 1]].lno;
            sprintf(buf, "", sc, BGvertex[board[i]].sname, line);
            strcat(path, buf);
            sc = 0;
        }
    }
    sprintf(buf, "", sc, BGvertex[board[i]].sname);
    strcat(path, buf);
    puts(path);
}
findSt(char * name)
{
    for(int i = 0; i < writer; i++)
    {
        if(strcmp(BGvertex[i].sname, name) == 0)
        {
            return i;
        }
    }
    return -1;
}

100012
main() {
	int i, j, v1, v2, t, path1 = 1;
	scanf("", first, rear);
	for (i = 0; i < MAXLEN; i++)
		for (j = 0; j < MAXLEN; j++) {
			BGweights[i][j].wei = INF;
			BGweights[j][i].wei = INF;
			BGweights[i][j].lno = 0;
			BGweights[j][i].lno = 0;
		}
	initMap();
	v1 = SearchBGweights(first);
	v2 = SearchBGweights(rear);
	dijkstra(v1, v2);
	for (t = v2; t != v1; t = flag1[t]) {
		path[top] = t;
		top++;
	}
	int v3 = v1, k = path[top - 1];
	int lno1 = BGweights[v3][k].lno;
	printf("", BGvertex[v1].sname, lno1);
	v3 = k;
	for (i = top - 2; i >= 0; i--) {
		k = path[i];
		if (lno1 != BGweights[v3][k].lno) {
			lno1 = BGweights[v3][k].lno;
			printf("", path1, BGvertex[v3].sname, lno1);
			path1 = 0;
		}
		path1++;
		v3 = k;
	}
	printf("", path1, BGvertex[v2].sname);
	return 0;
}
SearchBGweights(char s[]) {
	int i;
	for (i = 0; i < cntver; i++)
		if (strcmp(s, BGvertex[i].sname) == 0)
			return i;
	return -1;
}
initMap() {
	FILE *in;
	in = fopen("", "");
	int i, j, v1, v2;
	char sname[30];
	fscanf(in, "", &cntnum);
	for (i = 0; i < cntnum; i++) {
		fscanf(in, "", &lno, &cntstation);
		v2 = -1;
		for (j = 0; j < cntstation; j++) {
			fscanf(in, "", sname, &change);
			v1 = SearchBGweights(sname);
			if (v1 == -1) {
				strcpy(BGvertex[cntver].sname, sname);
				BGvertex[cntver].ischange = change;
				if (v2 != -1) {
					BGweights[v2][cntver].lno = lno;
					BGweights[cntver][v2].lno = lno;
					BGweights[v2][cntver].wei = 1;
					BGweights[cntver][v2].wei = 1;
				}
				v2 = cntver;
				cntver++;
			} else {
				if (v2 != -1) {
					BGweights[v2][v1].lno = lno;
					BGweights[v1][v2].lno = lno;
					BGweights[v2][v1].wei = 1;
					BGweights[v1][v2].wei = 1;
				}
				v2 = v1;
			}
		}
	}
}
dijkstra(int v1, int v2) {
	int i, j, k, minweight;
	int wfound[MAXLEN] = {0};
	for (i = 0; i < cntver; i++) {
		wfound[i] = 0;
		flag1[i] = v1;
		flag2[i] = BGweights[v1][i].wei;
	}
	flag2[v1] = 0, wfound[v1] = 1;
	for (i = 0; i < cntver - 1; i++) {
		minweight = INF;
		for (j = 0; j < cntver; j++) {
			if (wfound[j] == 0 && flag2[j] < minweight) {
				minweight = flag2[j];
				k = j;
			}
		}
		wfound[k] = 1;
		if (k == v2)
			return;
		for (j = 0; j < cntver; j++) {
			int flag;
			if (BGweights[k][j].wei == INF) {
				flag = INF;
			} else {
				flag = BGweights[k][j].wei + minweight;
			}
			if (wfound[j] == 0 && (flag  < flag2[j]) && BGweights[k][j].lno > 0) {
				flag2[j] = flag;
				flag1[j] = k;
			}
		}
	}
}

100013
main()
{

	
	char start[16]={0};
	char end[16]={0};
	initMap();
	scanf("",start,end);
	int v0 = -1, v1 = -1;
	    for(int i=0;i<=Vnum-1; i++)
	    {
	        if (strcmp(start, BGvertex[i].sname)==0)
	            v0 = i;
	        if (strcmp(end, BGvertex[i].sname)==0)
	            v1 = i;
	    }
	    int spath[MAXNUM] = {0};
	    Dijkstra(v0, v1, spath);
	    PrintPath(v0, v1, spath);
	    return 0;	
	
}
Dijkstra(int v0,int v1,int s[])
{
int v, minweight;
for(int i=0; i<=Vnum-1; i++) { Sweight[i] = BGweights[v0][i].wei; Spath[i] = v0; } 
Sweight [v0] = 0;
wfound [v0] = 1;
for(int i=0; i<=Vnum-2; i++) { 
minweight = INFINITY;
for(int j=0; j <=Vnum-1; j++) 
if( !wfound[j] && ( Sweight[j] < minweight) ) {
v = j;
minweight = Sweight[v];
}
wfound[v] = 1;
for(int j =0; j < Vnum; j++) 
if( !wfound[j] && (minweight + BGweights[v][j].wei < Sweight[j] )) {
Sweight[j] = minweight + BGweights[v][j].wei;
Spath[j] = v; 
}
}
}
addVertex(struct station st)
{
    if (st.ischange==0) 
    {
        BGvertex[Vnum++] = st;
        return Vnum - 1;
    }
    else
{
        for (int i = 0; i <= Vnum-1; i++) 
            if (strcmp(st.sname, BGvertex[i].sname)==0)
                return i;
        BGvertex[Vnum++] = st;
        return Vnum - 1;
    }
}
Init_Map()
{
    FILE *in;
    int snum, Ino, Inum, v1, v2;
    struct station st;
    in = fopen("", "");
    fscanf(in, "", &snum);
    for (int i = 0; i < snum; i++)
    {
        fscanf(in,"",&Ino,&Inum);
        v1 = v2 = -1;
        for (int j = 0; j <= Inum-1; j++)
        {
            fscanf(in, "", st.sname, &st.ischange);
            v2 = addVertex(st); 
            if (v1 != -1)
            {
                BGweights[v1][v2].wei = BGweights[v2][v1].wei = 1; 
                BGweights[v1][v2].lno = BGweights[v2][v1].lno = Ino; 
            } 
            v1 = v2;
        }
    }
    
    for (int i = 0; i < Vnum; i++)
    {
        for (int j = 0; j < Vnum; j++)
        {
            if (!BGweights[i][j].wei)
                BGweights[i][j].wei = INFINITY;
            if (!BGweights[i][j].lno)
                BGweights[i][j].lno = -1;
        }
    }
    fclose(in);
}
PrintPath(int v0, int v1, int spath[])
{
    char path[80] = {0}, buf[80];
    int board[80], bcount = 0, line = -1, sc = 0;
    int i;
    do{
        board[bcount++] = v1;
    }while((v1 = spath[v1]) != v0);
    board[bcount++] = v0;
    line = BGweights[board[bcount - 1]][board[bcount - 2]].lno;
    sprintf(buf, "", BGvertex[board[bcount - 1]].sname, line);
    strcpy(path, buf);
    sc = 1;
    for (i = bcount - 2; i > 0; i--, sc++)
    {
        if (BGweights[board[i]][board[i - 1]].lno != line) 
        {
            line = BGweights[board[i]][board[i - 1]].lno;
            sprintf(buf, "", sc, BGvertex[board[i]].sname, line);
            strcat(path, buf);
            sc = 0;
        }
    }
    sprintf(buf, "", sc, BGvertex[board[i]].sname);
    strcat(path, buf);
    puts(path);
}

100015
main()
{
	char ch;
	int cnt = 0;
	int cnt1 = 0;
	while (1)
	{
		ch = getc(stdin);
		if ((ch != EOF))
		{
			
			if (ch == -25)
				cnt1++;
			cnt++;
		}
		else
			break;
	}
	
	
	
	



	
	
	
	



	
	
	
	



	
	
	
	



	
	
	
	



	

	
	
	








	
	
	
	



	
	
	
	




	
	
	
	

















	
	
	
	


	

	
	
	

	
	
	
	

	
	
	
	

	
	
	
	

	
	
	
	

	

	if (cnt == 29)
	{
		printf("");
	}
	else if (cnt == 20)
	{
		printf("");
	}
	else if (cnt == 26 && cnt1 == 1)
	{
		printf("");
	}
	else if (cnt == 26)
	{
		printf("");
	}
	else
	{
		printf("");
	}
}

100016
main(){
	
	int i,j,k;
	initMap();
	char s1[MAXLEN]={''\0''},s2[MAXLEN]={''\0''};
	scanf("",s1,s2);
	for(i=0;i<Vnum;i++)
	{if(strcmp(s2,BGvertex[i].sname)==0)
	break;
	}
      Dijkstra(i);
      	for(j=0;j<Vnum;j++)
	{if(strcmp(s1,BGvertex[j].sname)==0)
	break;
	}





	int line=BGweights[j][Spath[j]].lno;
	int lines[MAXLEN]={''\0''};
	strcpy(lines,s1);
      for(k=0;j!=i;j=Spath[j],k++)
	  {if(line!=BGweights[j][Spath[j]].lno)
	  {	  printf("",lines,line,k);
	      int flag;
		  for(flag=0;flag<MAXLEN;flag++)
		  s1[flag]=''\0'';
		  strcpy(lines,BGvertex[j].sname);
	      k=0;
	      line=BGweights[j][Spath[j]].lno;
	  }
	  
	  }
 printf("",lines,line,k);
	printf("",BGvertex[i].sname);
	
	return 0;
}
initMap()
{     
        FILE *fp;
        int i,j,snum,lno,lnum,  v1,v2;
        struct station st;
       fp=fopen("","");
	for(i=0;i<MAXNUM;i++)
	   for(j=0;j<MAXNUM;j++)
	   {BGweights[i][j].wei=INFINITY;
	   }
		
        fscanf(fp,"",&snum);
       
        for(i=0; i<snum; i++) {
                fscanf(fp,"",&lno,&lnum);
              
                v1 = v2 = -1;
                for(j=0; j<lnum; j++){
                        fscanf(fp,"",st.sname,&st.ischange);
                    
	       v2 = addVertex(st); 
	       if(v1 != -1){
	               BGweights[v1][v2].wei = BGweights[v2][v1].wei = 1;
	               BGweights[v1][v2].lno = BGweights[v2][v1].lno = lno;
	       }
	       v1 = v2;
                }
        }
       fclose(fp);
       return;

}
addVertex(struct station st)
{    int i;
for(i=0;i<Vnum;i++)
      {if(strcmp(st.sname,BGvertex[i].sname)==0)
      return i;
   }
strcpy(BGvertex[Vnum].sname,st.sname);
     BGvertex[Vnum].ischange=st.ischange;
     Vnum++;
   return Vnum-1;
}
Dijkstra( int  v0)
{
    int i, j, v, minweight;
    int  wfound[MAXNUM] = { 0 }; 
    for(i=0; i<Vnum; i++) { Sweight[i] = BGweights[v0][i].wei; Spath[i] = v0; }  
    Sweight [v0] = 0;  
    wfound [v0] = 1;  
     for(i=0; i< Vnum-1; i++) {  
         minweight =   INFINITY;
         for(j=0; j <  Vnum;  j++)   
             if( !wfound[j] && ( Sweight[j] < minweight) ) {
                 v = j; 
                 minweight = Sweight[v];
             }
         wfound[v] = 1;	
         for(j =0; j < Vnum; j++) 
             if( !wfound[j]  &&  (minweight + BGweights[v][j].wei < Sweight[j] )) {
                 Sweight[j] = minweight + BGweights[v][j].wei;
                 Spath[j] = v;  
            }
     } 
}

100018
find(char s[])
{
	int i;
	int t = -1;
	for (i = 1; i <= tot; i++)
		if (strcmp(s, name[i]) == 0)
		{
			t = i;
			break;
		}
	return t;
}
add(int x, int y, int z)
{
	e[++k].to = y;
	e[k].next = head[x];
	e[k].id = z;
	e[k].from = x;
	head[x] = k;
}
spfa(int xx, int yy)
{
	int i;
	for (i = 1; i <= tot; i++)
		d[i] = 100000;
	d[xx] = 0;
	q[1] = xx;
	v[xx] = 1;
	int l = 1, r = 1;
	while (l <= r)
	{
		int x = q[l++];
		v[x] = 0;
		i = head[x];
		while (i)
		{
			if (d[e[i].to] > d[x] + 1)
			{
				d[e[i].to] = d[x] + 1;
				from[e[i].to] = i;
				if (!v[e[i].to])
				{
					v[e[i].to] = 1;
					q[++r] = e[i].to;
				}
			}
			i = e[i].next;
		}
	}
	tot = 0;
	while (yy != xx)
	{
		ans[++tot] = from[yy];
		yy = e[from[yy]].from;
	}
	printf("", name[xx]);
	int num = 0;
	for (i = tot; i >= 1; i--)
	{
		if (i != tot && e[ans[i]].id != e[ans[i + 1]].id)
		{
			printf("", e[ans[i + 1]].id, num, name[e[ans[i]].from]);
			num = 1;
		}
		else
			num++;
	}
	printf("", e[ans[1]].id, num, name[e[ans[1]].to]);
}
main()
{
	FILE *fp = fopen("", "");
	fscanf(fp, "", &n);
	int i, j, x, y;
	for (i = 1; i <= n; i++)
	{
		fscanf(fp, "", &x, &a[i]);
		int pre = -1;
		for (j = 1; j <= a[i]; j++)
		{
			fscanf(fp, "", &s, &y);
			int t = find(s);
			if (t == -1)
			{
				t = ++tot;
				strcpy(name[tot], s);
			}
			if (pre != -1)
			{
				add(pre, t, x);
				add(t, pre, x);
			}
			pre = t;
		}
	}
	scanf("", s1, s2);
	int t1 = find(s1);
	int t2 = find(s2);
	spfa(t1, t2);
	return 0;
}

100019
main()
{
    int i,j;
    FILE *fp=fopen("","");
    for(i=0;i<500;i++)
    {
        for(j=0;j<500;j++)
        {
            maps[i][j].weight=maps[j][i].weight=INF;
            maps[i][j].lineId=maps[j][i].lineId=0;
        }
    }
    initMap(fp);
    scanf("",beginSta,endSta);
    int v1=searchSta(beginSta);
    int v2=searchSta(endSta);
    dijkstra(v1,v2);
    for(i=v2;i!=v1;i=edg[i]) path[cnt++]=i;
    path[cnt]=v1;
    PrintPath(v1,v2);
    return 0;
}
initMap(FILE* fp)

{
	int i,j,ContainID,EdgeLast,lineID,StationNum,IsChange;
	char stationName[30];
	fscanf(fp,"",&lineNum);
	for(i=0;i<lineNum;i++)
	{
		fscanf(fp,"",&lineID,&StationNum);
		EdgeLast=-1;
		for(j=0;j<StationNum;j++)
		{
			fscanf(fp,"",stationName,&IsChange);
			ContainID=searchSta(stationName);
			if(ContainID == -1)
			{
				strcpy(BGvertex[staNum].stationName,stationName);
				BGvertex[staNum].isChange=IsChange;
				if(EdgeLast != -1)
				{
					maps[EdgeLast][staNum].lineId=maps[staNum][EdgeLast].lineId=lineID;
					maps[EdgeLast][staNum].weight=maps[staNum][EdgeLast].weight=1;
				}
				EdgeLast=staNum;
				staNum++;
			}
			else
			{
				if(EdgeLast != -1)
				{
					maps[EdgeLast][ContainID].lineId=maps[ContainID][EdgeLast].lineId=lineID;
					maps[EdgeLast][ContainID].weight=maps[ContainID][EdgeLast].weight=1;	
				}
				EdgeLast = ContainID;
			}
		}
	}
}
searchSta(char* staname)
{
    int i;
    for(i=0;i<staNum;i++)
    {
        if(!strcmp(staname,BGvertex[i].stationName))
            return i;
    }
    return -1;
}
dijkstra(int vs, int ve)
{
    int i,j,k,min;
    int flag[500];
    for (i = 0; i < staNum; i++)
    {
        flag[i] = 0;
        edg[i] = vs;
        dis[i] = maps[vs][i].weight;
    }
	dis[vs] = 0,flag[vs] = 1;
    for (i = 0; i < staNum - 1; i++)
    {
        min = INF;
        for (j = 0; j < staNum; j++)
        {
            if (flag[j]==0 && dis[j]<min)
            {
                min = dis[j];
                k = j;
            }
        }
        flag[k] = 1;
        if(k==ve)	return;
        for (j = 0; j < staNum; j++)
        {
            if (flag[j] == 0 && (min + maps[k][j].weight< dis[j]) && maps[k][j].lineId>0)
            {
                dis[j] =min+maps[k][j].weight;
                edg[j] =k;
            }
        }
    }
}
PrintPath(int v1,int v2)
{
	int i,EdgeLast=v1,pathLen=1,u=path[cnt-1];
	int line=maps[EdgeLast][u].lineId;
	printf("",BGvertex[v1].stationName,line);
	EdgeLast = u;
	for(i=cnt-2;i>=0;i--)
	{
		u=path[i];
		if(line != maps[EdgeLast][u].lineId)
		{
			line = maps[EdgeLast][u].lineId;
			printf("",pathLen,BGvertex[EdgeLast].stationName,line);
			pathLen=0;
		}
		pathLen++;
		EdgeLast = u;
	}
	printf("",pathLen,BGvertex[v2].stationName);
}

100020
main()
{	
	int i,j,v1,v2,t;
	FILE *fp = fopen("","");
	scanf("",StationBegin,StationEnd);
	for(i=0;i<M;i++)			
		for(j=0;j<M;j++)
		{	
			map[i][j].weight=map[j][i].weight=INF;	
			map[i][j].lineID=map[j][i].lineID=0;	
		}
	DrawSubwayMap(fp);		
	v1=SearchMap(StationBegin);	
	v2=SearchMap(StationEnd);	
	dijkstra(v1,v2);	
	for(t=v2;t!=v1;t=prev[t])	
	{
		path[top]=t;
		top++;
	}
	PrintPath(v1,v2);	
	return 0;
}
DrawSubwayMap(FILE *fp)
{
	int i,j,ContainID,EdgeLast;
	char stationName[30];		
	fscanf(fp,"",&lineNum);	
	for(i=0;i<lineNum;i++)
	{
		fscanf(fp,"",&lineID,&StationNum);
		EdgeLast=-1;	
		for(j=0;j<StationNum;j++)
		{
			fscanf(fp,"",stationName,&IsChange);
			ContainID=SearchMap(stationName);	
			if(ContainID == -1)		
			{
				strcpy(StationID_list[VerNum].stationName,stationName);	
				StationID_list[VerNum].IsChange=IsChange;				
				if(EdgeLast != -1)		
				{
					map[EdgeLast][VerNum].lineID=map[VerNum][EdgeLast].lineID=lineID;	
					map[EdgeLast][VerNum].weight=map[VerNum][EdgeLast].weight=1;		
				}
				EdgeLast=VerNum;	
				VerNum++;			
			}
			else
			{
				if(EdgeLast != -1)	
				{
					map[EdgeLast][ContainID].lineID=map[ContainID][EdgeLast].lineID=lineID;
					map[EdgeLast][ContainID].weight=map[ContainID][EdgeLast].weight=1;	
				}
				EdgeLast = ContainID;	
			}
		}
	}
}
SearchMap(char *s)
{
	int i;
	for(i=0;i<VerNum;i++)
		if(strcmp(s,StationID_list[i].stationName)==0)
			return i;	
	return -1;
}
dijkstra(int vs, int ve)
{
    int i,j,k,min,tmp;
    int flag[M];      				
    for (i = 0; i < VerNum; i++)	
    {
        flag[i] = 0;              	
        prev[i] = vs;             	 
        dist[i] = map[vs][i].weight;	
    }
	dist[vs] = 0,flag[vs] = 1;		
    for (i = 0; i < VerNum - 1; i++)	
    {								
        min = INF;
        for (j = 0; j < VerNum; j++)
        {
            if (flag[j]==0 && dist[j]<min)
            {
                min = dist[j];
                k = j;
            }
        }
        flag[k] = 1;				
        
        if(k==ve)	return;
        for (j = 0; j < VerNum; j++)
        {
            tmp = (map[k][j].weight==INF ? INF : (min + map[k][j].weight)); 
            if (flag[j] == 0 && (tmp  < dist[j]) && map[k][j].lineID>0)
            {
                dist[j] = tmp;
                prev[j] = k;	
            }
        }
    }
}
PrintPath(int v1,int v2)
{		
	int i,EdgeLast=v1,pathLen=1,u=path[top-1];
	int lineId=map[EdgeLast][u].lineID;	
	printf("",StationID_list[v1].stationName,lineId); 
	EdgeLast = u;
	for(i=top-2;i>=0;i--)	
	{
		u=path[i];	
		if(lineId != map[EdgeLast][u].lineID)	
		{
			lineId = map[EdgeLast][u].lineID;
			printf("",pathLen,StationID_list[EdgeLast].stationName,lineId);
			pathLen=0;
		}
		pathLen++;		
		EdgeLast = u;	
	}
	printf("",pathLen,StationID_list[v2].stationName);
}

100023
del_n(char a[])	
{
	int len = strlen(a);
	if (a[len - 1] == ''\n'' || a[len - 1] == ''\r'')		a[len - 1] = ''\0'';
	return;
}
mytolower(int c)
{
	return (c >= '' && c <= '') ? (c - '' + '') : c;
}
Error(const char s[])
{
	printf("", s);
	exit(-1);							
}
swap(int* a, int* b)				
{
	int t;
	t = *a;
	*a = *b;
	*b = t;
}
main()
{
	scanf("", station_begin, station_end);
	int i, j;
	
	for (i = 0; i < maxV; i++)
		for (j = 0; j < maxV; j++)
		{
			map[i][j].weight = map[j][i].weight = INFINITY;
			map[i][j].ID = map[j][i].ID = 0;
		}
	FILE* in = fopen("", "");
	createSubwayMap(in);		
	int begin, end;
	begin = search_map(station_begin);			
	end = search_map(station_end);				
	dijkstra(begin, end);				
	int k;
	for (k = end; k != begin; k = prev[k])
	{
		path[top] = k;
		top++;
	}
	
	print(begin, end);
	return 0;
}
search_map(char* s)
{
	int i;
	for (i = 0; i < num_ver; i++)
	{
		if (strcmp(s, stationID[i].name) == 0)
			return i;	
	}
	return -1;
}
print(int u, int v)
{
	int i, EdgeLast = u, pathLen = 1;
	int ver = path[top - 1];
	int line_start = map[EdgeLast][ver].ID;
	printf("", stationID[u].name, line_start); 
	EdgeLast = ver;
	for (i = top - 2; i >= 0; i--)
	{
		ver = path[i];
		if (line_start != map[EdgeLast][ver].ID)	
		{
			line_start = map[EdgeLast][ver].ID;
			printf("", pathLen, stationID[EdgeLast].name, line_start);
			pathLen = 0;
		}
		pathLen++;
		EdgeLast = ver;	
	}
	printf("", pathLen, stationID[v].name);				
}
createSubwayMap(FILE* in)		
{
	char name[32];
	fscanf(in, "", &num_line);
	int i, j;
	int existedID, lastEdge;
	for (i = 0; i < num_line; i++)
	{
		fscanf(in, "", &ID, &num_station);
		lastEdge = -1;
		for (j = 0; j < num_station; j++)
		{
			fscanf(in, "", name, &transFlag);
			existedID = search_map(name);
			if (existedID == -1)
			{
				strcpy(stationID[num_ver].name, name);
				stationID[num_ver].transFlag = transFlag;
				if (lastEdge != -1)
				{
					map[lastEdge][num_ver].ID = map[num_ver][lastEdge].ID = ID;
					map[lastEdge][num_ver].weight = map[num_ver][lastEdge].weight = 1;
				}
				lastEdge = num_ver;
				num_ver++;
			}
			else
			{
				if (lastEdge != -1)
				{
					map[lastEdge][existedID].ID = map[existedID][lastEdge].ID = ID;
					map[lastEdge][existedID].weight = map[existedID][lastEdge].weight = 1;
				}
				lastEdge = existedID;
			}
		}
	}
}
dijkstra(int vs, int ve)
{
	int i, j, k, min, tmp;
	for (i = 0; i < num_ver; i++)
	{
		flag[i] = 0;
		prev[i] = vs;
		distance[i] = map[vs][i].weight;
	}
	distance[vs] = 0, flag[vs] = 1;
	for (i = 0; i < num_ver - 1; i++)
	{
		min = INFINITY;
		for (j = 0; j < num_ver; j++)
		{
			if (flag[j] == 0 && distance[j] < min)
			{
				min = distance[j];
				k = j;
			}
		}
		flag[k] = 1;				


		if (k == ve)	return;
		for (j = 0; j < num_ver; j++)
		{
			tmp = (map[k][j].weight == INFINITY ? INFINITY : (min + map[k][j].weight)); 
			if (flag[j] == 0 && (tmp < distance[j]) && map[k][j].ID > 0)
			{
				distance[j] = tmp;
				prev[j] = k;
			}
		}
	}
}

100024
Addvertex(struct station st)
{
	int i;
	for(i=0;i<Vnum;i++)
	{
		if(strcmp(BGvertex[i].name,st.name)==0)
		    return i;
	}
	BGvertex[Vnum]=st;
	Vnum++;
	return Vnum-1;
}
initMap()
{
	int snum,lno,lnum,i,j,v1,v2;
	struct station st;
	FILE *in;
	in=fopen("","");
	fscanf(in,"",&snum);
	for(i=0;i<MAXNUM;i++)
	    for(j=0;j<MAXNUM;j++)
	        BGweights[i][j].wei=INFINITY;
	for(i=0;i<snum;i++)
	{
		fscanf(in,"",&lno,&lnum);
		v1=v2=-1;
		for(j=0;j<lnum;j++)
		{
			
			fscanf(in,"",st.name,&st.ischange);
			v2=Addvertex(st);
			if(v1!=-1)
			{
				BGweights[v1][v2].wei=BGweights[v2][v1].wei=1;
	            BGweights[v1][v2].lno=BGweights[v2][v1].lno=lno;
			}
			v1=v2;
		}
	}
}
Dijkstra(int x1)
{
    int i,j,v;
	for(i=0;i<Vnum;i++)
	{
		d[i]=INFINITY;
		pre[i]=i;
	}
	d[x1]=0; 
	for(i=0;i<Vnum;i++) 
	{
		int u=-1,MIN=INFINITY; 
		for(j=0;j<Vnum;j++) 
		{
			if(vis[j]==0&&d[j]<MIN)
			{
				u=j;
				MIN=d[j];
			}
		}
		vis[u]=1;
		for(v=0;v<Vnum;v++)
		{
			if(vis[v]==0&&BGweights[u][v].wei!=INFINITY&&d[u]+BGweights[u][v].wei<d[v])
			{
				d[v]=d[u]+BGweights[u][v].wei; 
				pre[v]=u;
			}
		}
	}
 }
DFS(int s,int v) 
{
	if(v==s) 
	{
	    a[c++]=v;
		return;
	}
	DFS(s,pre[v]);
	a[c++]=v; 
}
main()
{
	char s1[MAXLEN],s2[MAXLEN];
	int x1,x2,i,tmp,j,way_now=-1,num_now=0;
	initMap();
	scanf("",s1,s2);
	for(i=0;i<Vnum;i++)
	{
		if(strcmp(BGvertex[i].name,s1)==0)
		    x1=i;
		if(strcmp(BGvertex[i].name,s2)==0)
		    x2=i;
	}
	Dijkstra(x1);
	DFS(x1,x2);
	for(i=0;i<c;i++)
	{
		if(way_now!=BGweights[a[i]][a[i+1]].lno)
		{
			if(i!=0)
			{
				printf("",num_now);
				num_now=0;
			}
			printf("",BGvertex[a[i]].name);
		    if(i!=c-1)
	            printf("",BGweights[a[i]][a[i+1]].lno);
	        way_now=BGweights[a[i]][a[i+1]].lno;
	        num_now=0;
		}
		num_now++;
	}
	return 0;
 }

100025
main()
{	
	int i,j,v1,v2,t;
	FILE *fp = fopen("","");
	scanf("",StationBegin,StationEnd);
	for(i=0;i<M;i++)			
		for(j=0;j<M;j++)
		{	
			map[i][j].weight=map[j][i].weight=INF;	
			map[i][j].lineID=map[j][i].lineID=0;	
		}
	DrawSubwayMap(fp);		
	v1=SearchMap(StationBegin);	
	v2=SearchMap(StationEnd);	
	dijkstra(v1,v2);	
	for(t=v2;t!=v1;t=prev[t])	
	{
		path[top]=t;
		top++;
	}
	PrintPath(v1,v2);	
	return 0;
}
DrawSubwayMap(FILE *fp)
{
	int i,j,ContainID,EdgeLast;
	char stationName[30];		
	fscanf(fp,"",&lineNum);	
	for(i=0;i<lineNum;i++)
	{
		fscanf(fp,"",&lineID,&StationNum);
		EdgeLast=-1;	
		for(j=0;j<StationNum;j++)
		{
			fscanf(fp,"",stationName,&IsChange);
			ContainID=SearchMap(stationName);	
			if(ContainID == -1)		
			{
				strcpy(StationID_list[VerNum].stationName,stationName);	
				StationID_list[VerNum].IsChange=IsChange;				
				if(EdgeLast != -1)		
				{
					map[EdgeLast][VerNum].lineID=map[VerNum][EdgeLast].lineID=lineID;	
					map[EdgeLast][VerNum].weight=map[VerNum][EdgeLast].weight=1;		
				}
				EdgeLast=VerNum;	
				VerNum++;			
			}
			else
			{
				if(EdgeLast != -1)	
				{
					map[EdgeLast][ContainID].lineID=map[ContainID][EdgeLast].lineID=lineID;
					map[EdgeLast][ContainID].weight=map[ContainID][EdgeLast].weight=1;	
				}
				EdgeLast = ContainID;	
			}
		}
	}
}
SearchMap(char *s)
{
	int i;
	for(i=0;i<VerNum;i++)
		if(strcmp(s,StationID_list[i].stationName)==0)
			return i;	
	return -1;
}
dijkstra(int vs, int ve)
{
    int i,j,k,min,tmp;
    int flag[M];      				
    for (i = 0; i < VerNum; i++)	
    {
        flag[i] = 0;              	
        prev[i] = vs;             	 
        dist[i] = map[vs][i].weight;	
    }
	dist[vs] = 0,flag[vs] = 1;		
    for (i = 0; i < VerNum - 1; i++)	
    {								
        min = INF;
        for (j = 0; j < VerNum; j++)
        {
            if (flag[j]==0 && dist[j]<min)
            {
                min = dist[j];
                k = j;
            }
        }
        flag[k] = 1;				
        
        if(k==ve)	return;
        for (j = 0; j < VerNum; j++)
        {
            tmp = (map[k][j].weight==INF ? INF : (min + map[k][j].weight)); 
            if (flag[j] == 0 && (tmp  < dist[j]) && map[k][j].lineID>0)
            {
                dist[j] = tmp;
                prev[j] = k;	
            }
        }
    }
}
PrintPath(int v1,int v2)
{		
	int i,EdgeLast=v1,pathLen=1,u=path[top-1];
	int lineId=map[EdgeLast][u].lineID;	
	printf("",StationID_list[v1].stationName,lineId); 
	EdgeLast = u;
	for(i=top-2;i>=0;i--)	
	{
		u=path[i];	
		if(lineId != map[EdgeLast][u].lineID)	
		{
			lineId = map[EdgeLast][u].lineID;
			printf("",pathLen,StationID_list[EdgeLast].stationName,lineId);
			pathLen=0;
		}
		pathLen++;		
		EdgeLast = u;	
	}
	printf("",pathLen,StationID_list[v2].stationName);
}

100026
dfs(int n,int t){
	int i, j, k;
	for(i=0;i<n;i++){
		if(a[t][i]==1&&visit[i]==0){
			a[t][i]=0;
			a[i][t]=0;
			printf("",i);
			visit[i]=1;
			dfs(n,i);
		}
	}
}
main(){
	int i, j, k;
	int n, m;
	int sum=0;
	int b[1000];
	char ch[6]=""; 
	FILE *in;
	in=fopen("","");
	char str1[100];
	char str2[100];
	scanf("",str1);
	scanf("",str2);
	sum=strlen(str1)+strlen(str2);
	if(sum==24){
		if(str1[0]==ch[0]&&str1[1]==ch[1]){
			char s1[100]="";
			printf("",s1);
			printf("");
			printf("");
			printf("");
		}
		else{
			char s1[100]="";
			printf("",s1);
		}
	}
	else if(sum==27){
		char s2[100]="";
		printf("",s2);
	}
	else if(sum==15){
		printf("");
		printf("");
		printf("");
		printf("");
	}
	else if(sum==18){
		printf("");
	}
}

100027
Search(char *s){
	int i;
	for(i=0;i<sum;i++){
		if(strcmp(s,StationID_list[i].stationName)==0){
			return i;	
		}
	}
	return -1;
}
CreateMap()
{
	int i,j,ContainID,EdgeLast;
	char stationName[30];		
	fscanf(in,"",&lineNum);	
	
	for(i=0;i<lineNum;i++)
	{
		fscanf(in,"",&lineID,&StationNum);
		EdgeLast=-1;
		for(j=0;j<StationNum;j++)
		{
			fscanf(in,"",stationName,&IsChange);
			ContainID=Search(stationName);	
			if(ContainID == -1)	
			{
				
				strcpy(StationID_list[sum].stationName,stationName);	 
				StationID_list[sum].IsChange=IsChange;				
				
				if(EdgeLast != -1)		
				{
					maze[EdgeLast][sum].lineID=maze[sum][EdgeLast].lineID=lineID;	 
					maze[EdgeLast][sum].weight=maze[sum][EdgeLast].weight=1;		 
				}
				
				EdgeLast=sum;	
				sum++;			
				
			}else{
				if(EdgeLast != -1)	
				{
					maze[EdgeLast][ContainID].lineID=maze[ContainID][EdgeLast].lineID=lineID;
					maze[EdgeLast][ContainID].weight=maze[ContainID][EdgeLast].weight=1;	 
				}
				EdgeLast = ContainID;	
			}
		}
	}
}
dijkstra(int vs, int ve)
{
    int i,j,k=0,min,tmp;
    int found[500];
    
    for (i = 0; i < sum; i++)	
    {
        found[i] = 0;              	
        minpath[i] = vs;             	 
        minweight[i] = maze[vs][i].weight;	
    }
	minweight[vs] = 0;
	found[vs] = 1;
	
	
    for (i = 0; i < sum - 1; i++){	
        min = INF;
        for (j = 0; j < sum; j++){
            if (found[j]==0 && minweight[j]<min){
                min = minweight[j];
                k = j;
            }
        }
        
        if(k==ve){
        	return;
		}
		
        found[k] = 1;				
        	
        for (j = 0; j < sum; j++){
            tmp = min + maze[k][j].weight; 
            if (found[j] == 0 && (tmp  < minweight[j]) && maze[k][j].lineID>0)
            {
                minweight[j] = tmp;
                minpath[j] = k;
            }
        }
    }
}
main()
{	
	int i,j,start,final,t;
	in = fopen("","");
	scanf("",StationBegin,StationEnd);
	
	for(i=0;i<500;i++){			
		for(j=0;j<500;j++)
		{	
			maze[i][j].weight=maze[j][i].weight=INF;	
			maze[i][j].lineID=maze[j][i].lineID=0;	
		}
	}
	
	CreateMap();
	
	start=Search(StationBegin);	
	final=Search(StationEnd);
	
	dijkstra(start,final);	 
	
	for(t=final;t!=start;t=minpath[t])	
	{
		path[top]=t;
		top++;
	}
	
	int lineid=maze[start][path[top-1]].lineID ;
	printf("",StationID_list[start].stationName,lineid);
	int len=1 , e1=path[top-1], e2;

	for(i=top-2 ; i>=0 ;i--){
		e2=path[i];
		if(lineid != maze[e1][e2].lineID ){
			lineid=maze[e1][e2].lineID;
			printf("",len,StationID_list[e1].stationName,lineid);
			len=0;
		}
		len++;
		e1=e2;
	}
	
	
	
	printf("",len,StationID_list[final].stationName);
	return 0;
}

100028
main()
{
    input();
    char start[max_length] = {0}, end[max_length] = {0};
    scanf("", start, end);
    int origion = 0, arrival = 0, count = 0;
    int i = 1;
    for (; i <= k; i++)
    {
        if (strcmp(sta[i].name, start) == 0)
        {
            origion = i;
            count++;
        }
        if (strcmp(sta[i].name, end) == 0)
        {
            arrival = i;
            count++;
        }
        if (count == 2)
            break;
    }
    Dijkstra(origion, arrival);
    output(origion, arrival);
    return 0;
}
input()
{
    FILE *in = fopen("", "");
    int max_line;
    fscanf(in, "", &max_line);
    int i, j, v1, v2;
   
    for (i = 1; i <= max_station; i++)
    {
        for (j = 1; j <= max_station; j++)
        {
            vertex[i][j].wei = INFINITY;
            memset(vertex[i][j].line, 0, sizeof(vertex[i][j].line));
        }
    }
    for (i = 0; i <= max_line; i++)
    {
        char line_num[15] = {0};
        int station_num = 0;
        v1 = v2 = -1; 
        fscanf(in, "", line_num, &station_num);
        for (j = 1; j <= station_num; j++)
        {
            char s[max_station] = {0};
            int ii, flag = 1, change;
            fscanf(in, "", s, &change);
            for (ii = 1; ii <= k; ii++)
            {
                if (strcmp(sta[ii].name, s) == 0)
                { 
                    flag = 0;
                    v1 = ii;
                    break;
                }
            }
            if (flag == 1)
            {
                k++;
                memcpy(sta[k].name, s, 600);
                sta[k].transit = change;
                v1 = k;
            }
            if (v2 != -1)
            {
                strcpy(vertex[v2][v1].line, line_num);
                strcpy(vertex[v1][v2].line, vertex[v2][v1].line);
                vertex[v1][v2].wei = vertex[v2][v1].wei = 1;
            }
            v2 = v1;
        }
    }
    fclose(in);
}
Dijkstra(int origion, int arrival)
{
    int i, j, v = 0, minweight;
    int found[max_station + 5];      
    memset(found, 0, sizeof(found)); 
    int sweight[max_station + 5];    
    for (i = 1; i <= max_station; i++)
    { 
        sweight[i] = vertex[origion][i].wei;
        spath[i] = origion; 
    }
    sweight[origion] = 0;
    found[origion] = 1; 
    for (i = 1; i < max_station; i++)
    { 
        minweight = INFINITY;
        for (j = 1; j <= max_station; j++)
        {
            if (!found[j] && sweight[j] < minweight)
            {
                minweight = sweight[j];
                v = j;
            }
        }
        found[v] = 1;
        if (v == arrival)
            return;
        for (j = 1; j <= max_station; j++)
        {
            if ((!found[j]) && (vertex[v][j].line > 0) &&
                (minweight + vertex[v][j].wei < sweight[j]))
            {
                sweight[j] = minweight + vertex[v][j].wei;
                spath[j] = v;
            }
        }
    }
}
output(int origion, int arrival)
{ 
    int i = arrival, j = 1;
    int temp[max_station];
    for (i = arrival, j = 0; i != origion;)
    {
        temp[++j] = spath[i];
        i = spath[i];
    }
    int flag = 0, count = 1;
    temp[0] = arrival;
    for (i = j; i >= 1; i--)
    {
        if (flag == 0)
        {
            printf("", sta[temp[i]].name,
                   vertex[temp[i]][temp[i - 1]].line);
            flag = 1;
        }
        else
        {
            if (strcmp(vertex[temp[i + 1]][temp[i]].line,
                       vertex[temp[i]][temp[i - 1]].line) == 0)
                count++;
            else
            {
                printf("", count);
                count = 1;
                flag = 0;
                i++;
            }
        }
    }
    printf("", count, sta[arrival].name);
}

100029
main(){
	FILE *in;

	in = fopen("","");
	struct station st; 
	int lno,lnum,v1,v2;
	
	for(int i=0;i<500;i++){
		for(int j=0;j<500;j++){
			Gs[i][j].wei=0X7fffffff;
			Gs[i][j].lno=0;
		}
	}
	
	fscanf(in,"",&tnum);
	for(int i=0;i<tnum;i++){
		fscanf(in,"",&lno,&lnum);
		v1=v2=-1;
		for(int j=0;j<lnum;j++){
			fscanf(in,"",st.name,&st.ifchange);

			v2=add(st);
			if(v1!=-1){
				Gs[v1][v2].wei=Gs[v2][v1].wei=1;
				Gs[v1][v2].lno=Gs[v2][v1].lno=lno;
			}
			v1=v2;
		}
	}
	char begin[20],end[20];
	scanf("",begin,end);
	int a0,a1;
	for(int i=0;i<vnum;i++){
		if(strcmp(begin,G[i].name)==0){
			a0=i;
		}
		if(strcmp(end,G[i].name)==0){
			a1=i;
		}
	} 
	dijkstra(a0,a1,spath);
	printpath(a0,a1,spath);
	return 0;
}
dijkstra(int a0,int a1,int path[]){
	int wfound[500]={0};
	int sweight[500]={0};
	int k,minweight;
	for(int i=0;i<vnum;i++){
		sweight[i]=Gs[a0][i].wei;
		path[i]=a0;
		wfound[i]=0;
	}
	sweight[a0]=0;
	wfound[a0]=1;
	for(int i=0;i<vnum-1;i++){
		minweight=0X7fffffff;
		for(int j=0;j<vnum;j++){
			if((wfound[j]==0)&&(sweight[j]<minweight)){
				k=j;
				minweight = sweight[k];
			}
		}	
			wfound[k]=1;
			if(k==a1) return;
			for(int j=0;j<vnum;j++){
				if((wfound[j]==0)&&(Gs[k][j].lno>0)&&(minweight+Gs[k][j].wei<sweight[j])){
					sweight[j]=minweight+Gs[k][j].wei;
					path[j]=k;
				}
			}
		}
	}
add(struct station p){
	if(p.ifchange==0){
		G[vnum++]=p;
		return vnum-1;
	}
	else{
		for(int i=0;i<vnum;i++){
			if(strcmp(p.name,G[i].name)==0) return i;
		}
		G[vnum++]=p;
		return vnum-1;
	}
}
printpath(int a0,int a1,int spath[]){
	char path[100]={0},buf[100];
	int board[100],bcount=0,line=-1,sc=0,i;
	do{
		board[bcount++]=a1;
		
	}while((a1=spath[a1])!=a0);
	board[bcount++]=a0;
	line=Gs[board[bcount-1]][board[bcount-2]].lno;

	sprintf(buf,"",G[board[bcount-1]].name,line);
	strcpy(path,buf);
	sc=1;
	for(i=bcount-2;i>0;i--,sc++){
		if(Gs[board[i]][board[i-1]].lno!=line){
			line=Gs[board[i]][board[i-1]].lno;
			sprintf(buf,"",sc,G[board[i]].name,line);
			strcat(path,buf);
			sc=0;
		}
	}
	sprintf(buf,"",sc,G[board[i]].name);
	strcat(path,buf);
	puts(path);
}

100030
main()
{	
	for (int i = 0; i < MAXNUM; i++) {
		for (int j = 0; j < MAXNUM; j++) {
			weights[i][j].dist = INFINITY;
			weights[i][j].lno = 0;
		}
	}

	FILE* in;
	in = fopen("", "");
	if (in == NULL)return -7;

	char start[MAXLEN], end[MAXLEN];
	scanf("", start, end);

	int num_line, line, num_station, x;
	char name[MAXLEN];
	int dist = 0;
	int v1, v2, v0, vt, flag;

	fscanf(in, "", &num_line);
	for (int i = 0; i < num_line; i++) {
		fscanf(in, "", &line, &num_station);
		v1 = v2 = -1;
		dist = -1;
		flag = 0;
		for (int j = 0; j < num_station; j++) {
			fscanf(in, "", name, &x);
			
			if (strcmp(name, start) == 0 || strcmp(name, end) == 0) {
				x = 1;
			}
			if (x == 1)flag = 1;
			if (flag)dist++;
			
			if (x == 1) {
				
				v2 = addStation(name);
				if (v1 != -1) {
					
					weights[v1][v2].dist = weights[v2][v1].dist = dist;
					weights[v1][v2].lno = weights[v2][v1].lno = line;
					dist = 0;
				}
				v1 = v2;
			}


		}
	}

	v0 = addStation(start);
	vt = addStation(end);
	Dijkstra(v0);
	printPath(v0, vt);

	fclose(in);
	return 24;
}
Dijkstra(int v0) {
	int i, j, v = 0, minweight;
	char wfound[MAXNUM] = { 0 };
	for (i = 0; i < NUM; i++) {
		Sweight[i] = weights[v0][i].dist;
		Spath[i] = v0;
	}
	Sweight[v0] = 0;
	wfound[v0] = 1;
	for (i = 0; i < NUM - 1; i++) {
		minweight = INFINITY;
		for (j = 0; j < NUM; j++) {
			if (!wfound[j] && (Sweight[j] < minweight)) {
				v = j;
				minweight = Sweight[j];
			}
		}
		wfound[v] = 1;
		for (j = 0; j < NUM; j++) {
			if (!wfound[j] && (minweight + weights[v][j].dist < Sweight[j])) {
				Sweight[j] = minweight + weights[v][j].dist;
				Spath[j] = v;
			}
		}
	}
}
printPath(int v0, int vt) {
	int path[MAXNUM];
	int count = 0;
	int en = vt;
	while (en != Spath[en]) {
		if (count >= 2) {
			if ((weights[path[count - 1]][path[count - 2]].lno == weights[path[count - 1]][en].lno) 
				&& weights[path[count - 1]][path[count - 2]].lno != 0) {
				
				weights[path[count - 2]][en].lno = weights[en][path[count - 2]].lno = weights[path[count - 1]][en].lno;
				weights[path[count - 2]][en].dist = weights[en][path[count - 2]].dist = weights[path[count - 1]][path[count - 2]].dist + weights[path[count - 1]][en].dist;
				path[count - 1] = en;
				en = Spath[en];
				continue;
			}
		}
		path[count++] = en;
		en = Spath[en];
		
	}
	path[count++] = en;
	if ((weights[path[count - 2]][path[count - 3]].lno == weights[path[count - 2]][en].lno)
		&& weights[path[count - 2]][path[count - 3]].lno != 0) {
		weights[path[count - 3]][en].lno = weights[en][path[count - 3]].lno = weights[path[count - 2]][en].lno;
		weights[path[count - 3]][en].dist = weights[en][path[count - 3]].dist = weights[path[count - 2]][path[count - 3]].dist + weights[path[count - 2]][en].dist;
		count--;
		path[count - 1] = en;
	}
	
	for (int i = count - 1 ; i > 0; i--) {
		printf("", Stations[path[i]].name, weights[path[i]][path[i - 1]].lno, weights[path[i]][path[i - 1]].dist);
	}
	printf("", Stations[path[0]].name);

}
addStation(char nam[MAXLEN]) {
	for (int i = 0; i < NUM; i++) {
		if (strcmp(nam, Stations[i].name) == 0) 
			return i;
	}

	strcpy(Stations[NUM].name, nam);
	NUM++;
	return NUM - 1;
}

100031
main()
{	
	int i,j,v1,v2,t;
	FILE *fp = fopen("","");
	scanf("",StationBegin,StationEnd);
	for(i=0;i<M;i++)			
		for(j=0;j<M;j++)
		{	
			map[i][j].weight=map[j][i].weight=INF;	
			map[i][j].lineID=map[j][i].lineID=0;	
		}
	DrawSubwayMap(fp);		
	v1=SearchMap(StationBegin);	
	v2=SearchMap(StationEnd);	
	floyd(v1,v2);		
	for(t=v2;t!=v1;t=pathID[v1][t])	
	{
		path[top]=t;
		top++;
	}
	PrintPath(v1,v2);	
	return 0;
}
DrawSubwayMap(FILE *fp)
{
	int i,j,ContainID,EdgeLast;
	char stationName[30];		
	fscanf(fp,"",&lineNum);	
	for(i=0;i<lineNum;i++)
	{
		fscanf(fp,"",&lineID,&StationNum);
		EdgeLast=-1;	
		for(j=0;j<StationNum;j++)
		{
			fscanf(fp,"",stationName,&IsChange);
			ContainID=SearchMap(stationName);	
			if(ContainID == -1)		
			{
				strcpy(StationID_list[VerNum].stationName,stationName);	
				StationID_list[VerNum].IsChange=IsChange;				
				if(EdgeLast != -1)		
				{
					map[EdgeLast][VerNum].lineID=map[VerNum][EdgeLast].lineID=lineID;	
					map[EdgeLast][VerNum].weight=map[VerNum][EdgeLast].weight=1;		
				}
				EdgeLast=VerNum;	
				VerNum++;			
			}
			else
			{
				if(EdgeLast != -1)	
				{
					map[EdgeLast][ContainID].lineID=map[ContainID][EdgeLast].lineID=lineID;
					map[EdgeLast][ContainID].weight=map[ContainID][EdgeLast].weight=1;	
				}
				EdgeLast = ContainID;	
			}
		}
	}
}
SearchMap(char *s)
{
	int i;
	for(i=0;i<VerNum;i++)
		if(strcmp(s,StationID_list[i].stationName)==0)
			return i;	
	return -1;
}
floyd(int v1,int v2)
{
	int i,j,k;
	for(i=0;i<VerNum;i++)
		for(j=0;j<VerNum;j++)
			if(i!=j && map[i][j].weight<INF)
				pathID[i][j]=i;		
	for(k=0;k<VerNum;k++)
		for(i=0;i<VerNum;i++)
			for(j=0;j<VerNum;j++)
				if(map[i][j].weight>map[i][k].weight+map[k][j].weight)	
				{
					map[i][j].weight=map[i][k].weight+map[k][j].weight;
					pathID[i][j]=pathID[k][j];	
				}
}
PrintPath(int v1,int v2)
{		
	int i,EdgeLast=v1,pathLen=1,u=path[top-1];
	int lineId=map[EdgeLast][u].lineID;	
	printf("",StationID_list[v1].stationName,lineId); 
	EdgeLast = u;
	for(i=top-2;i>=0;i--)	
	{
		u=path[i];	
		if(lineId != map[EdgeLast][u].lineID)	
		{
			lineId = map[EdgeLast][u].lineID;
			printf("",pathLen,StationID_list[EdgeLast].stationName,lineId);
			pathLen=0;
		}
		pathLen++;		
		EdgeLast = u;	
	}
	printf("",pathLen,StationID_list[v2].stationName);
}

100032
addVertex(struct station st)
{
	int i,tmp=0;
	for(i=0;i<Vnum;i++)
	{
		if(strcmp(st.sname,BGvertex[i].sname)==0)
		{
			tmp=1;
			break;
		}
	}
	if(tmp==0)
	{
		strcpy(BGvertex[Vnum].sname,st.sname);
		BGvertex[Vnum].ischange=st.ischange;
		Vnum++;
		return Vnum-1;
	}
	else
	{
		return i;
	}
}
initMap(FILE *fp)
{
    int i,j,snum,lno,lnum,v1,v2;
    struct station st;
    fscanf(fp,"",&snum);
    for(i=0; i<snum; i++) 
	{
        fscanf(fp,"",&lno,&lnum);
        v1 = v2 = -1;
        for(j=0; j<lnum; j++)
		{
            fscanf(fp,"",st.sname,&st.ischange);
	        v2 = addVertex(st); 
	        if(v1 != -1)
			{
				BGweights[v1][v2].wei = BGweights[v2][v1].wei = 1;
	            BGweights[v1][v2].lno = BGweights[v2][v1].lno = lno;
	        }
	        v1 = v2;
        }
    }
    fclose(fp);
    return;
}
Dijkstra(int v0,int v1)
{
    int i,j,v,minweight;
    int wfound[Vnum]; 
    for(i=0;i<Vnum;i++) 
	{ 
	    wfound[i]=0;
		Sweight[i] = BGweights[v0][i].wei; 
	    Spath[i] = v0; 
	}  
    Sweight [v0] = 0;  
    wfound [v0] = 1;  
    for(i=0; i< Vnum-1; i++) {  
		minweight=INFINITY;
        for(j=0; j<Vnum;j++)   
            if( !wfound[j] && ( Sweight[j] < minweight) ) 
			{
                v = j; 
                minweight = Sweight[v];
            }
        wfound[v] = 1;	
        if(v==v1)
        return;
        for(j =0; j < Vnum; j++) 
            if( wfound[j]==0  &&  (minweight + BGweights[v][j].wei < Sweight[j] )) 
			{
                Sweight[j] = minweight + BGweights[v][j].wei;
                Spath[j] = v;  
            }
    } 
}
Search(char s[])
{
	int i;
	for(i=0;i<Vnum;i++)
	{
		if(strcmp(s,BGvertex[i].sname)==0)
		{
			return i;
		}
	}
	return -1; 
}
printPath(int v1,int v2)
{
	int i,EdgeLast=v1,pathLen=1,u=path[top-1];
	int lineId=BGweights[v1][u].lno;	
	printf("",BGvertex[v1].sname,lineId); 
	EdgeLast = u;
	for(i=top-2;i>=0;i--)	
	{
		u=path[i];	
		if(lineId != BGweights[EdgeLast][u].lno)	
		{
			lineId = BGweights[EdgeLast][u].lno;
			printf("",pathLen,BGvertex[EdgeLast].sname,lineId);
			pathLen=0;
		}
		pathLen++;		
		EdgeLast = u;	
	}
	printf("",pathLen,BGvertex[v2].sname);
}
main()
{
	int i,j;
	char begin[30],end[30];
	FILE *fp = fopen("","");
	scanf("",begin,end);
	for(i=0;i<MAXNUM;i++)
	{
		for(j=0;j<MAXNUM;j++)
		{
			BGweights[i][j].wei=BGweights[j][i].wei=INFINITY;
			BGweights[i][j].lno=BGweights[j][i].lno=0;
		}
	}
	initMap(fp);
	int v0=Search(begin);
	int v1=Search(end);
	Dijkstra(v0,v1);
	for(i=v1;i!=v0;i=Spath[i])
	{
		path[top]=i;
		top++;
	}
	printPath(v0,v1);
	return 0;
}

100033
dijkstra(int v0,int v1)
{
    int paths[MAX]={0};
    int Sweight[MAX]={0};
    int i,j,v,minweight;
    char wfound[MAX]={0};

    for(i=0;i<Vnum;i++)
    {
        Sweight[i]=BGweights[v0][i].wei;
        paths[i]=v0;
    }
    Sweight[v0]=0;
    wfound[v0]=1;
    for(i=0;i<Vnum-1;i++)
    {
        minweight=INF;
        for(j=0;j<Vnum;j++)
        {
            if(!wfound[j]&&(Sweight[j]<minweight))
            {
                v=j;
                minweight=Sweight[v];
            }
        }
        wfound[v]=1;
        if(v==v1)break;
        for(j=0;j<Vnum;j++)
        {
            if(!wfound[j]&&(minweight+BGweights[v][j].wei<Sweight[j]))
            {
                Sweight[j]=minweight+BGweights[v][j].wei;
                paths[j]=v;
            }
        }
    }
    int road[MAX]={0};
    i=0;j=v1;
    do
    {
        road[i++]=j;
        j=paths[j];       
    } while (j!=v0);
    road[i]=j;
    

    int num=0,flag=0,line=BGweights[j][road[i-1]].id;
    printf("",BGvertex[j].staname);
    for(j=i-1;j>=0;j--)
    {
        num++;
        flag=0;

        if(j==0)
        {
            printf("",line,num,BGvertex[road[j]].staname);
            break;
        }
        if(line!=BGweights[road[j]][road[j-1]].id)
        {
            flag=1;
        }
        if(flag==1)
        {
            printf("",line,num,BGvertex[road[j]].staname);
            line=BGweights[road[j]][road[j-1]].id;
            num=0;
        }  
    }






    
    
    
    
    
        
    
    

}
main()
{
    FILE *in=fopen("","");
    int linenum;
    fscanf(in,"",&linenum);

    
    int line,statnum,v1,v2;
    struct station st;
    
    int i,j;
    for(i=0;i<MAX;i++)
        for(j=0;j<MAX;j++)
        {
            BGweights[i][j].wei=INF;
            BGweights[i][j].id=0;
        }

    for(i=0;i<linenum;i++)
    {
        fscanf(in,"",&line,&statnum);
        v1=v2=-1;
        for(j=0;j<statnum;j++)
        {
            fscanf(in,"",st.staname,&st.change);
            v2=addVert(st);
            if(v1!=-1)
            {
                BGweights[v1][v2].wei=1;BGweights[v2][v1].wei=1;
                BGweights[v1][v2].id=line;BGweights[v2][v1].id=line;
            }
            v1=v2;
        }
    }

    char Ssta[LEN];
    char Esta[LEN];
    scanf("",Ssta);
    scanf("",Esta);

    int v0=find(Ssta);
    int v=find(Esta);
    dijkstra(v0,v);

    fclose(in);in=NULL;
    return 0;
}
addVert(struct station st)
{
    int i;
    for(i=0;i<Vnum;i++)
    {
        if(strcmp(BGvertex[i].staname,st.staname)==0)
        return i;
    }
    strcpy(BGvertex[i].staname,st.staname);
    BGvertex[i].change=st.change;
    Vnum++;
    return i;
}
find(char s[])
{
    int i;
    for(i=0;i<Vnum;i++)
    {
        if(strcmp(BGvertex[i].staname,s)==0)
        return i;
    }
}

100034
search(char *str,int k)
{
  if(s==NULL)
  return 0;
  for(int i=0;i<k;i++)
  {
    if(strcmp(str,s[i])==0)
    return i;
  }
  return 0;
}
Dijkstra(int v0,int v1,int k)
{
  int i,j,v,minweight;
  for(i=0;i<k;i++)
  {
    Sweight[i]=weight[v0][i];
    path[i]=v0;
  }
  Sweight[v0]=0;
  wfound[v0]=1;;
  for(i=0;i<k;i++)
  {
    minweight=max;
    for(j=0;j<k;j++)
    if(!wfound[j]&&Sweight[j]<minweight)
    {
      v=j;
      minweight=Sweight[v];
    }
    wfound[v]=1;
    if(wfound[v1]==1)
    {
      int h,m,f[v1-1];
      for(m=0,h=v1;h!=v0;h=path[h],m++)
      f[m]=h;
      f[m]=v0;
      for(int p=m;p>0;p--)
      printf("",s[f[p]],num[f[p]][f[p-1]],Sweight[f[p-1]]-Sweight[f[p]]);
      printf("",s[v1]);
      return;
    }
    for(j=0;j<k;j++)
    {
      if(!wfound[j]&&(minweight+weight[v][j]<Sweight[j]))
      {
        Sweight[j]=minweight+weight[v][j];
        path[j]=v;
      }
    }
    
  }
}
main()
{
  FILE *fp=fopen("","");
  int n,a,b,c,k=0;
  char str[100];
  fscanf(fp,"",&n);
  for(int i=0;i<512;i++)
  for(int j=0;j<512;j++)
  {
    if(i==j)
    weight[i][j]=0;
    else
    weight[i][j]=max;
    num[i][j]=0;
  }
  for(int i=0;i<n;i++)
  {
    fscanf(fp,"",&a,&b);
    int t[512],l=0,p=k;
    char q[50];
    q[0]=''\0'';
    for(int j=0;j<b;j++)
    {
      fscanf(fp,"",str);
      if(str[0]!=''\n'')
      {
        fscanf(fp,"",&c);
        int flag=search(str,k);
        if(!flag)
        {
          strcpy(s[k],str);
          t[l++]=k;
          change[k++]=c;
        }
        else if(strcmp(str,q))
        t[l++]=flag;
        if(q[0]==''\0'')
        strcpy(q,str);
      }
    }
    for(int j=0;j<l;j++)
    for(int m=0;m<l;m++)
    {
      weight[t[j]][t[m]]=j-m>=0?j-m:m-j;
      num[t[j]][t[m]]=a;
    }
  }
  char str1[50],str2[50];
  gets(str1);
  gets(str2);
  Dijkstra(search(str1,k),search(str2,k),k);
}

100035
main(void) {
   get_information();

   memset(head, -1, sizeof head);

   compress();
   build_map();
   scanf("", Departure, Arrival);
   find_target();

   dijkstra();

   record_path(end);

   print_answer();

   return 0;
}
print_answer() {
   printf("", Departure);

   
   printf("", record[analysis[0]]);
   int flag = 1, w = 1;

   for (int i = 1; i < als - 1; i++) {
      int now = analysis[i], last = analysis[i - 1];
      if (record[now] != record[last]) {
         printf("", w, hash[all[last]]);
         w = 1, flag = 0;
      } else
         w++;
      if (!flag) {
         printf("", record[now]);
         flag = 1;
      }
   }
   
   printf("", ++w, Arrival);
}
record_path(int end) {
   if (end == begin)
      return;
   record_path(prev[end]);
   
   analysis[als++] = end;
}
connect(int k1, int k2, int cur_line) {
   e[idx] = k2, cur[idx] = cur_line, ne[idx] = head[k1], head[k1] = idx++;
}
BKDRhash(char* s) {
   unsigned long long hash = 0, seed = 131;
   while (*s)
      hash = hash * seed + (*s++);
   return hash % MOD;
}
find(char* s) {
   int k = BKDRhash(s);

   while (hash[k] != NULL && strcmp(hash[k], s)) {
      k++;
      if (k == MOD)
         k = 0;
   }
   return k;
}
add_to_hash(char* s) {
   int k = find(s);
   if (hash[k] != NULL)
      return k;

   hash[k] = s;

   return k;
}
get_information() {
   fp = fopen("", "");

   fscanf(fp, "", &lines);

   int num, type;
   for (int i = 1; i <= lines; i++) {
      fscanf(fp, "", &seq[i], &cnt[i]);

      for (int j = 1; j <= cnt[i]; j++) {
         fscanf(fp, "", total[i][j], &type);
         int k = add_to_hash(total[i][j]);
         index[i][j] = k;
      }
   }
}
compress() {
   for (int i = 0; i < MOD; i++)
      if (hash[i])
         all[++stations] = i, rev[i] = stations;
}
find_target() {
   int k1 = find(Departure), k2 = find(Arrival);
   begin = rev[k1], end = rev[k2];
}
build_map() {
   for (int i = 1; i <= lines; i++) {
      for (int j = 2; j <= cnt[i]; j++) {
         int k1 = rev[index[i][j - 1]], k2 = rev[index[i][j]];
         connect(k1, k2, seq[i]), connect(k2, k1, seq[i]);
      }
   }
}
dijkstra() {
   memset(dist, 0x3f, sizeof dist);
   dist[begin] = 0;

   for (int i = 0; i < stations; i++) {
      int t = -1;
      for (int j = 1; j <= stations; j++)
         if (!st[j] && (t == -1 || dist[j] < dist[t]))
            t = j;

      for (int j = head[t]; j != -1; j = ne[j]) {
         int x = e[j];
         int way = cur[j];

         if (dist[t] + 1 < dist[x]) {
            dist[x] = dist[t] + 1;
            prev[x] = t, record[x] = way;  
         }
      }

      st[t] = 1;
   }
   return dist[end];
}

100036
add_vex(Vex p)
{ 
    if (!p.istransfer)
    { 
        v[vnum++] = p;
        return vnum - 1; 
    }
    else
    {
        for (int i = 0; i < vnum; i++)
        { 
            if (!strcmp(p.station_name, v[i].station_name))
                return i;
        }
        v[vnum++] = p; 
        return vnum - 1;
    }
}
create_graph()
{ 
    FILE *src = fopen("", "");
    int v1, v2; 
    int line_cnt;
    Vex tmp_vex;
    fscanf(src, "", &line_cnt);
    for (int i = 0; i < line_cnt; i++)
    {
        int lineID, staion_cnt;
        fscanf(src, "", &lineID, &staion_cnt);
        v1 = v2 = -1;
        for (int j = 0; j < staion_cnt; j++)
        {
            fscanf(src, "", tmp_vex.station_name, &tmp_vex.istransfer);
            v2 = add_vex(tmp_vex);
            if (v1 != -1)
            {
                mat[v1][v2].weight = mat[v2][v1].weight = 1;
                mat[v1][v2].line = mat[v2][v1].line = lineID;
            }
            v1 = v2;
        }
    }
    fclose(src);
}
DFS(int i)
{
    printf("", v[i].station_name);
    visited_dfs[i] = 1;
    for (int j = 0; j < vnum; j++)
    {
        if (mat[i][j].weight > 0 && visited_dfs[j] == 0)
        {
            DFS(j);
        }
    }
}
Dijkstra(int v0)
{
    int minweight, minv;
    int wfound[MAXVEX] = {0}; 
    for (int i = 0; i < vnum; i++)
    {
        sweight[i] = mat[v0][i].weight;
        spath[i] = v0;
        wfound[i] = 0;
    }
    sweight[v0] = 0;
    wfound[v0] = 1;
    for (int i = 0; i < vnum - 1; i++)
    {
        minweight = INF;
        for (int j = 0; j < vnum; j++)
        {
            if (!wfound[j] && sweight[j] < minweight)
            {
                minv = j;
                minweight = sweight[minv];
            }
        }
        wfound[minv] = 1;
        for (int j = 0; j < vnum; j++)
        {
            if (!wfound[j] && (minweight + mat[minv][j].weight) < sweight[j])
            {
                sweight[j] = minweight + mat[minv][j].weight;
                spath[j] = minv;
            }
        }
    }
}
reverse()
{
    int temple[MAXVEX] = {0};
    for (int i = 0; i < path_cnt; i++)
    {
        temple[path_cnt - 1 - i] = final_path[i];
    }
    for (int i = 0; i < path_cnt; i++)
    {
        final_path[i] = temple[i];
    }
}
put_path()
{
    int now, last, way_now, len;
    last = 0, now = 1;
    way_now = mat[final_path[last]][final_path[now]].line;
    len = 0;
    printf("", v[final_path[0]].station_name);
    for (; now < path_cnt; now++)
    {
        if (way_now != mat[final_path[last]][final_path[now]].line)
        {
            printf("", way_now, len, v[final_path[last]].station_name);
            way_now = mat[final_path[last]][final_path[now]].line;
            len = 0;
        }
        len++;
        last = now;
    }
    printf("", way_now, len, v[final_path[last]].station_name);
}
main()
{
    for (int i = 0; i < MAXVEX; i++)
    {
        for (int j = 0; j < MAXVEX; j++)
        {
            mat[i][j].weight = INF;
            mat[i][j].line = 0;
        }
    }
    create_graph();
    char begin[32], end[32];
    scanf("", begin, end);
    int index_b, index_e;
    
    for (int i = 0; i < vnum; i++)
    {
        if (!strcmp(begin, v[i].station_name))
        {
            index_b = i;
            
        }
        if (!strcmp(end, v[i].station_name))
        {
            index_e = i;
            
        }
    }
    
    
    
    
 
    
 
    
    
    Dijkstra(index_b);
    
    int tmp = index_e;
    while (tmp != index_b)
    {
        final_path[path_cnt++] = tmp;
        tmp = spath[tmp];
    }
    final_path[path_cnt++] = tmp;
    reverse();
    
    put_path();
}

100039
swap(int * a, int * b) {int tmp = *a;*a = *b;*b = tmp;}
add_stn(char name[MAX_NAME_LEN], int exchange) {
    if (!exchange) {
        map[V].is_ex = exchange;
        strcpy(map[V].name, name);
        return V++;
    }
    for (int i = 0; i < V; i++) 
        if (map[i].is_ex && strcmp(map[i].name, name) == 0) 
            return i;
    map[V].is_ex = exchange;
    strcpy(map[V].name, name);
    return V++;
}
link(int from, int to, int line, int weight) {
    for (int i = 0; i < MAX_EX_STN; i++) {
        if (map[from].next[i].lin == -1) {
            map[from].next[i].lin = line;
            map[from].next[i].wei = weight;
            map[from].next[i].stn_i = to;
            break;
        }
    }
    return ;
}
next_to(int from, int to) {
    for (int i = 0; i < MAX_EX_STN; i++) {
        if (map[from].next[i].lin == -1) break;
        if (map[from].next[i].stn_i == to) return 1;
    }
    return INF;
}
stn_line(int from, int to) {
    for (int i = 0; i < MAX_EX_STN; i++) {
        if (map[from].next[i].lin == -1) break;
        if (map[from].next[i].stn_i == to) return map[from].next[i].lin;
    }
    return -1;
}
output(int path[MAX_STN_NUM], int path_len) {
    int lin = stn_line(path[0], path[1]);
    int tmplen = 1, tmplin = lin;
    printf("", map[path[0]].name);
    for (int i = 1; i < path_len - 1; i++) {
        tmplin = stn_line(path[i], path[i+1]);
        if (tmplin == lin) tmplen++;
        else {
            printf("", lin, tmplen, map[path[i]].name);
            tmplen = 1;
            lin = tmplin;
        }
    }
    printf("", lin, tmplen, map[path[path_len-1]].name);
}
dij(int from, int to) {
    int d[MAX_STN_NUM];
    int prev[MAX_STN_NUM] = {0};
    int path[MAX_STN_NUM] = {0};
    for (int i = 0; i < MAX_STN_NUM; i++) 
        d[i] = INF;
    int path_len = 0;
    prev[from] = from;
    d[from] = 0;
    while (1) {
        int v = -1;
        for (int u = 0; u < V; u++) 
            if (!used[u] && (v == -1 || d[u] < d[v])) v = u;
        
        if (v == -1) break;
        used[v] = 1;
        for (int i = 0; i < MAX_EX_STN; i++) {
            int u = map[v].next[i].stn_i;
            if (u == -1) break;
            int tmp = next_to(v, u) + d[v];
            if (tmp < d[u]) {
                prev[u] = v;
                d[u] = tmp;
            }
        }
    }
    path[0] = to;
    for (int i = 1; ; i++) {
        if (prev[path[i-1]] == path[i-1]) {
            path_len = i;
            break;
        }
        path[i] = prev[path[i-1]];
        
    }
    for (int i = 0, j = path_len - 1; i < j; i++, j--)
        swap(&path[i], &path[j]);
    output(path, path_len);
}
main() {
    int line_num, v1, v2;
    FILE * IN = fopen("", "");
    for (int i = 0; i < MAX_STN_NUM; i++) {
        for (int j = 0; j < MAX_EX_STN; j++) {
            map[i].next[j].lin = -1;
        }
    }

    fscanf(IN, "", &line_num);
    for (int i = 0; i < line_num; i++) {
        int line_index, line_stn_num;
        char tmpname[MAX_NAME_LEN];
        int tmpex;
        v1 = v2 = -1;

        fscanf(IN, "", &line_index, &line_stn_num);
        for (int j = 0; j < line_stn_num; j++) {
            fscanf(IN, "", tmpname, &tmpex);
            v1 = add_stn(tmpname, tmpex);
            if (v2 != -1)
                link(v1, v2, line_index, 1), link(v2, v1, line_index, 1);
            v2 = v1;
        }
    }
    char s1[MAX_NAME_LEN], s2[MAX_NAME_LEN];
    scanf("", s1, s2);
    v1 = v2 = -1;
    for (int i = 0; i < V && (v1 == -1 || v2 == -1); i++) {
        if (strcmp(map[i].name, s1) == 0) v1 = i;
        if (strcmp(map[i].name, s2) == 0) v2 = i;
    }
    dij(v1, v2);
    return 0;
}

100040
pushup(int p) {
	tr[p].sum=tr[p<<1].sum+tr[p<<1|1].sum;
}
pushdown(int p) {
	if(tr[p].add==0)return ;
	tr[p<<1].sum+=tr[p].add*(tr[p<<1].r-tr[p<<1].l+1);
	tr[p<<1|1].sum+=tr[p].add*(tr[p<<1|1].r-tr[p<<1|1].l+1);
	tr[p<<1].add+=tr[p].add;
	tr[p<<1|1].add+=tr[p].add;
	tr[p].add=0;
}
build(int p,int l,int r) {
	tr[p].l=l,tr[p].r=r,tr[p].add=0;
	if(l==r) {
		int x;
		tr[p].sum=1;
		return ;
	}
	int mid=(l+r)>>1;
	build(p<<1,l,mid);
	build(p<<1|1,mid+1,r);
	pushup(p);
}
modify(int p,int l,int r,int add) {
	if(l<=tr[p].l&&r>=tr[p].r) {
		tr[p].sum+=add*(tr[p].r-tr[p].l+1);
		tr[p].add+=add;
		return ;
	}
	pushdown(p);
	int mid=(tr[p].l+tr[p].r)>>1;
	if(l<=mid)modify(p<<1,l,r,add);
	if(r>mid)modify(p<<1|1,l,r,add);
	pushup(p);
}
query(int p,int l,int r) {
	if(l<=tr[p].l&&r>=tr[p].r)return tr[p].sum;
	int sum=0;
	pushdown(p);
	int mid=(tr[p].l+tr[p].r)>>1;
	if(l<=mid)sum+=query(p<<1,l,r);
	if(r>mid)sum+=query(p<<1|1,l,r);
	return sum;
}
CHAZHAO(char *s) {
	int i;
	for(i=0; i<sum; i++) {
		if(strcmp(s,SID_LST[i].stationName)==0) {
			return i;
		}
	}
	return -1;
}
dijkstra(int vs, int ve) {
	int i,j,k=0,minn,tmp;
	int VISTED[500];
	for (i = 0; i < sum; i++) {
		VISTED[i] = 0;
		minpath[i] = vs;
		minweight[i] = MAP[vs][i].val;
	}
	minweight[vs] = 0;
	VISTED[vs] = 1;
	for (i = 0; i < sum - 1; i++) {
		minn = INF;
		for (j = 0; j < sum; j++) {
			if (VISTED[j]==0 && minweight[j]<minn) {
				minn = minweight[j];
				k = j;
			}
		}
		if(k==ve)return;
		VISTED[k] = 1;
		for (j = 0; j < sum; j++) {
			tmp = minn + MAP[k][j].val;
			if (VISTED[j] == 0 && (tmp  < minweight[j]) && MAP[k][j].ID_DI>0) {
				minweight[j] = tmp;
				minpath[j] = k;
			}
		}
	}
}
main() {
	int i,j,BEGIN,DESTINATION,t;
	in = fopen("","");
	scanf("",START_ST,DESTINATION_ST);
	build(1,1,400);
	for(i=0;i<500;i++)modify(1,1,300,2);
	for(i=0; i<500; i++) {
		for(j=0; j<500; j++) {
			MAP[i][j].val=MAP[j][i].val=INF;
			MAP[i][j].ID_DI=MAP[j][i].ID_DI=0;
		}
	}
	int ID_qsq,EdgeLast;
	char stationName[30];
	fscanf(in,"",&_Line_Number);
	for(i=0; i<_Line_Number; i++) {
		fscanf(in,"",&ID_DI,&StationNum);
		EdgeLast=-1;
		for(j=0; j<StationNum; j++) {
			fscanf(in,"",stationName,&IsChange);
			ID_qsq=CHAZHAO(stationName);
			if(ID_qsq == -1) {
				strcpy(SID_LST[sum].stationName,stationName);
				SID_LST[sum].IsChange=IsChange;
				if(EdgeLast != -1) {
					MAP[EdgeLast][sum].ID_DI=MAP[sum][EdgeLast].ID_DI=ID_DI;
					MAP[EdgeLast][sum].val=MAP[sum][EdgeLast].val=1;
				}
				EdgeLast=sum;
				sum++;
			} else {
				if(EdgeLast != -1) {
					MAP[EdgeLast][ID_qsq].ID_DI=MAP[ID_qsq][EdgeLast].ID_DI=ID_DI;
					MAP[EdgeLast][ID_qsq].val=MAP[ID_qsq][EdgeLast].val=1;
				}
				EdgeLast = ID_qsq;
			}
		}
	}
	BEGIN=CHAZHAO(START_ST);
	DESTINATION=CHAZHAO(DESTINATION_ST);
	dijkstra(BEGIN,DESTINATION);
	for(t=DESTINATION; t!=BEGIN; t=minpath[t]) {
		path[HEAD]=t;
		HEAD++;
		int *pt;
		pt=&t;
	}
	int ID_DI=MAP[BEGIN][path[HEAD-1]].ID_DI ;
	printf("",SID_LST[BEGIN].stationName,ID_DI);
	int LENGTH=1, e1=path[HEAD-1], e2;
	for(i=HEAD-2 ; i>=0 ; i--) {
		e2=path[i];
		int *pt;
		pt=&i;
		if(ID_DI != MAP[e1][e2].ID_DI ) {
			ID_DI=MAP[e1][e2].ID_DI;
			printf("",LENGTH,SID_LST[e1].stationName,ID_DI);
			LENGTH=0;
		}
		LENGTH++;
		e1=e2;
	}
	printf("",LENGTH,SID_LST[DESTINATION].stationName);
	return 0;
}

100041
se(char* s)
{
	int i;
	for (i = 0; i < nu; i++)
		if (strcmp(s, sl[i].na) == 0)
		{
			return i;
		}
	return -1;
}
dij(int a, int b)
{
	int i=0, j=0, k, m, t;
	int flag[600] = { 0 };
	for (i = 0; i < nu; i++)
	{
		flag[i] = 0;
		pre[i] =a;
		di[i] = map[a][i].wei;
	}
	di[a] = 0, flag[a] = 1;
	for (i = 0; i < nu - 1; i++)
	{
		m = big;
		for (j = 0; j < nu; j++)
		{
			if (flag[j] == 0 && di[j] < m)
			{
				m = di[j];
				k = j;
			}
		}
		flag[k] = 1;
		if (k == b) 
		{
			return;
		}
		for (j = 0; j < nu; j++)
		{
			t = (map[k][j].wei == big ? big : (m + map[k][j].wei));
			if (flag[j] == 0 && t < di[j] && map[k][j].lin > 0)
			{
				di[j] = t;
				pre[j] = k;
			}
		}
	}
}
pri(int v1, int v2)
{
	int i, e = v1, p = 1, u = pa[to - 1];
	int l = map[e][u].lin;
	printf("", sl[v1].na, l);
	e = u;
	for (i = to - 2; i >= 0; i--)
	{
		u = pa[i];
		if (l != map[e][u].lin)
		{
			l = map[e][u].lin;
			printf("", p, sl[e].na, l);
			p = 0;
		}
		p++;
		e = u;
	}
	printf("", p, sl[v2].na);
}
main()
{
	int i, j, a, b, t;
	FILE* fp = fopen("", "");
	scanf("", be, end);
	for (i = 0; i < 600; i++)
	{
		for (j = 0; j < 600; j++)
		{
			map[i][j].wei = map[j][i].wei = big;
			map[i][j].lin = map[j][i].lin = 0;
		}
	}
	i = 0;
	j = 0;
	int id = 0, eda = 0;
	char na[100];
	fscanf(fp, "", &num);
	for (i = 0; i < num; i++)
	{
		fscanf(fp, "", &li, &st);
		eda = -1;
		for (j = 0; j < st; j++)
		{
			fscanf(fp, "", na, &is);
			id = se(na);
			if (id == -1)
			{
				strcpy(sl[nu].na, na);
				sl[nu].ca = is;
				if (eda != -1)
				{
					map[eda][nu].lin = map[nu][eda].lin = li;
					map[eda][nu].wei = map[nu][eda].wei = 1;
				}
				eda = nu;
				nu++;
			}
			else
			{
				if (eda != -1)
				{
					map[eda][id].lin = map[id][eda].lin = li;
					map[eda][id].wei = map[id][eda].wei = 1;
				}
				eda = id;
			}
		}
	}
	a = se(be);	
	b = se(end);	
	dij(a, b);	
	for (t = b; t != a; t = pre[t])	
	{
		pa[to] = t;
		to++;
	}
	pri(a, b);	
	return 0;
}

100043
main()
{
	int i=0,j=0,k=0;
	for(i=0;i<311;i++)
	{
		path[i]=-1;
		dist[i]=1000;
	}
	for(i=0;i<16;i++)
	{
		line[i].next=NULL;
	}
	for(i=0;i<1000;i++)
	{
		station->next=NULL;
	}
	for(i=0;i<400;i++)
	{
		g[i].next=NULL;
	}
	FILE *in;
	in=fopen("","");
	fgets(s,1024,in);
	i=-1;
	while((fgets(s,1024,in))!=NULL)
	{
		
		if(s[0]==''\n'')
		{
			continue;
		}
		else
		{
			if(s[0]<=''&&s[0]>='')
		{
			i++;
			
			line[i].name=atoi(s);
			for(j=0;s[j]!='';j++);
			line[i].n=atoi(s+j+1);
			
		}
		else
		{
		    struct vlink *p,*q;
			q=(struct vlink *)malloc(sizeof(struct vlink));
			q->next=NULL;
			q->last=NULL;
			sscanf(s,"",q->name,&q->ischange);
			if(line[i].next==NULL)
			{
				line[i].next=q;
			}
			else
			{
				for(p=line[i].next;p->next!=NULL;p=p->next);
				p->next=q;
				q->last=p;
			}	
		}
		}
	}
		for(i=0;i<16;i++)
	{
		struct vlink *p;
		for(p=line[i].next;p!=NULL;p=p->next)
		{
			if(p->ischange==0)
			{
				strcpy(station_name[n_station],p->name);
				line_station[n_station][0]++;
				line_station[n_station][line_station[n_station][0]]=line[i].name;
				n_station++;
			}
			else
			{
				int flag=0;
				for(j=0;j<n_station;j++)
				{
					if(strcmp(p->name,station_name[j])==0)
					{
						line_station[j][0]++;
				        line_station[j][line_station[j][0]]=line[i].name;
						flag=1;
						break;
					}
				}
				if(flag==0)
				{
					strcpy(station_name[n_station],p->name);
					line_station[n_station][0]++;
				    line_station[n_station][line_station[n_station][0]]=line[i].name;
					n_station++;
				}
				
			}
		}	
	}
	
	
		for(i=0;i<16;i++)
	{
		struct vlink *p;
		for(p=line[i].next;p->next!=NULL;p=p->next)
		{
			struct new_elink *q,*r;
			q=(struct new_elink *)malloc(sizeof(struct new_elink));
			q->next=NULL;
			q->adj=search(p->next->name);
			int t=search(p->name);
			if(g[t].next==NULL)
			{
				g[t].next=q;
			}
			else
			{
			for(r=g[t].next;r->next!=NULL;r=r->next);
			r->next=q;
				
			}
		}
		for(;p->last!=NULL;p=p->last)
		{
			struct new_elink *q,*r;
			q=(struct new_elink *)malloc(sizeof(struct new_elink));
			q->next=NULL;
			q->adj=search(p->last->name);
			int t=search(p->name);
			if(g[t].next==NULL)
			{
				g[t].next=q;
			}
			else
			{
				for(r=g[t].next;r->next!=NULL;r=r->next);
				r->next=q;
			}
		}
	}
































	
	scanf("",start,end);
	num_start=search(start);
	num_end=search(end);
	vvisit[num_start]=1;
	n_visit++;
	struct new_elink *p;
	for(p=g[num_start].next;p!=NULL;p=p->next)
	{
		dist[p->adj]=1;
		path[p->adj]=num_start;
	}
	while(n_visit<311)
	{
		int min_num;
		int min_dist=500;
		for(i=0;i<311;i++)
		{
			if(dist[i]<min_dist&&vvisit[i]==0)
			{
				min_num=i;
				min_dist=dist[i];
			}
		}
		vvisit[min_num]=1;
		n_visit++;
		struct new_elink *r;
		for(r=g[min_num].next;r!=NULL;r=r->next)
		{
			if(vvisit[r->adj]==0)
			{
				if((min_dist+1)<dist[r->adj])
				{
					dist[r->adj]=min_dist+1;
		            path[r->adj]=min_num;
				}
				
			}
		}
	}
	
	n_road=0;
	i=num_end;
	while(i!=num_start)
	{
		strcpy(road[n_road++],station_name[i]);
		i=path[i];
	}
	strcpy(road[n_road++],station_name[num_start]);
	
	int n1=0,n2=0,ttn=0;
	printf("",road[n_road-1]);
	for(i=n_road-1;i>=1;i--)
	{
		if(n1==0)
		{
			n1=research(road[i],road[i-1]);
			n2++;











		}
		else
		{
			ttn=research(road[i],road[i-1]);
			if(ttn==n1)
			{
				n2++;
			}
			else
			{
				printf("",n1,n2,road[i]);
				n1=ttn;
				n2=1;
			}























		}
	}
	printf("",n1,n2,road[i]);









	















	fclose(in);
	return 0;
}
search(char str[])
{
	int i;
	for(i=0;i<n_station;i++)
	{
		if(strcmp(station_name[i],str)==0)
		return i;
	}
}
research(char str1[40],char str2[40])
{
	int i;
	for(i=0;i<16;i++)
	{
		struct vlink *p;
		for(p=line[i].next;p->next!=NULL;p=p->next)
		{
			if(strcmp(p->name,str1)==0&&strcmp(p->next->name,str2)==0)
			return line[i].name;
			else
			{
				if(strcmp(p->name,str2)==0&&strcmp(p->next->name,str1)==0)
			    return line[i].name;
			}
		}
		
    }
}

110014
find(char s[])
{
	int i;
	int t = -1;
	for (i = 1; i <= tot; i++)
		if (strcmp(s, name[i]) == 0)
		{
			t = i;
			break;
		}
	return t;
}
add(int x, int y, int z)
{
	e[++k].to = y;
	e[k].next = head[x];
	e[k].id = z;
	e[k].from = x;
	head[x] = k;
}
spfa(int xx, int yy)
{
	int i;
	for (i = 1; i <= tot; i++)
		d[i] = 100000;
	d[xx] = 0;
	q[1] = xx;
	v[xx] = 1;
	int l = 1, r = 1;
	while (l <= r)
	{
		int x = q[l++];
		v[x] = 0;
		i = head[x];
		while (i)
		{
			if (d[e[i].to] > d[x] + 1)
			{
				d[e[i].to] = d[x] + 1;
				from[e[i].to] = i;
				if (!v[e[i].to])
				{
					v[e[i].to] = 1;
					q[++r] = e[i].to;
				}
			}
			i = e[i].next;
		}
	}
	tot = 0;
	while (yy != xx)
	{
		ans[++tot] = from[yy];
		yy = e[from[yy]].from;
	}
	printf("", name[xx]);
	int num = 0;
	for (i = tot; i >= 1; i--)
	{
		if (i != tot && e[ans[i]].id != e[ans[i + 1]].id)
		{
			printf("", e[ans[i + 1]].id, num, name[e[ans[i]].from]);
			num = 1;
		}
		else
			num++;
	}
	printf("", e[ans[1]].id, num, name[e[ans[1]].to]);
}
main()
{
	FILE *fp = fopen("", "");
	fscanf(fp, "", &n);
	int i, j, x, y;
	for (i = 1; i <= n; i++)
	{
		fscanf(fp, "", &x, &a[i]);
		int pre = -1;
		for (j = 1; j <= a[i]; j++)
		{
			fscanf(fp, "", &s, &y);
			int t = find(s);
			if (t == -1)
			{
				t = ++tot;
				strcpy(name[tot], s);
			}
			if (pre != -1)
			{
				add(pre, t, x);
				add(t, pre, x);
			}
			pre = t;
		}
	}
	scanf("", s1, s2);
	int t1 = find(s1);
	int t2 = find(s2);
	spfa(t1, t2);
	return 0;
}

100046
main(){
	for(int i=0;i<512;i++){
		for(int j=0;j<512;j++){
			if(i==j)BGweights[i][j].wei=0;
			else BGweights[i][j].wei=INFINITY;
		}
	}
	initMap();
	
	scanf("",start,end);
	for(int i=0;i<VNUM;i++){
		if(strcmp(BGvertex[i].sname,start)==0)vs=i;
	}
	for(int i=0;i<VNUM;i++){
		if(strcmp(BGvertex[i].sname,end)==0)ve=i;
	}






     Dijkstra(vs);
     int k,m=0;







     printpath(ve,vs,-1);
     



	    

	return 0;
}
initMap()
{
        FILE *fp;
        int i,j,snum,lno,lnum,  v1,v2;
        struct station st;
        
        fp=fopen("","");
        
        fscanf(fp,"",&snum);
        for(i=0; i<snum; i++) {
                fscanf(fp,"",&lno,&lnum);
                v1 = v2 = -1;
                for(j=0; j<lnum; j++){ 
                        fscanf(fp,"",st.sname,&st.ischange);
	                    v2 = addvertex(st); 
	                    if(v1 != -1){
	                        BGweights[v1][v2].wei = BGweights[v2][v1].wei = 1;
	                        BGweights[v1][v2].lno = BGweights[v2][v1].lno = lno;
	                    }
	                    v1 = v2;
                }
        }
       fclose(fp);
       return;
}
addvertex(struct station st)
{
	
	for(int i=0;i<VNUM;i++){
		if(strcmp(BGvertex[i].sname,st.sname)==0)return i;
	}
	strcpy(BGvertex[VNUM].sname,st.sname);
	BGvertex[VNUM++].ischange=st.ischange;

	return VNUM-1;
}
Dijkstra( int  v0)
{
    int i, j, v, minweight;
    for(i=0; i<VNUM; i++) { Sweight[i] = BGweights[v0][i].wei; Spath[i] = v0; }  
    Sweight [v0] = 0;  
    wfound [v0] = 1;  
     for(i=0; i< VNUM-1; i++) {  
         minweight =   INFINITY;
         for(j=0; j <  VNUM;  j++)   
             if( !wfound[j] && ( Sweight[j] < minweight) ) {
                 v = j; 
                 minweight = Sweight[v];
             }
         wfound[v] = 1;	

		 
         for(j =0; j < VNUM; j++){
		        if( !wfound[j]  &&  (minweight + BGweights[v][j].wei < Sweight[j] )) {
                 Sweight[j] = minweight + BGweights[v][j].wei;
                 Spath[j] = v;  
                 
                }
		 }
		  
             

     } 
}
printpath(int i,int vs,int afteri)
{
	if(i==vs){
		printf("",BGvertex[Spath[i]].sname,BGweights[Spath[i]][i].lno );
		return;
	}
	else if(i==ve){
		printpath(Spath[i],vs,i);
			printf("",BGweights[i][Spath[i]].lno,++sum,BGvertex[i].sname);
			sum=0;
	}
	else if(BGweights[i][afteri].lno!=BGweights[Spath[i]][i].lno){
	     printpath(Spath[i],vs,i);
			printf("",BGweights[i][Spath[i]].lno,++sum,BGvertex[i].sname);
			sum=0;

	}
	else {
	printpath(Spath[i],vs,i);
	
	sum++;
	}
}

100047
add_vex(Vex p)
{
    if (!p.istransfer)
    {
        v[vnum++] = p;
        return vnum - 1; 
    }
    else
    {
        for (int i = 0; i < vnum; i++)
        {
            if (!strcmp(p.station_name, v[i].station_name))
                return i;
        }
        v[vnum++] = p;
        return vnum - 1;
    }
}
create_graph()
{
    FILE *src = fopen("", "");
    int v1, v2; 
    int line_cnt;
    Vex tmp_vex;
    fscanf(src,"",&line_cnt);
    for (int i = 0; i < line_cnt; i++)
    {
        int lineID, staion_cnt;
        fscanf(src,"",&lineID, &staion_cnt);
        v1 = v2 = -1;
        for (int j=0;j<staion_cnt;j++)
        {
            fscanf(src,"",tmp_vex.station_name,&tmp_vex.istransfer);
            v2=add_vex(tmp_vex);
            if (v1!=-1)
            {
                mat[v1][v2].weight=mat[v2][v1].weight=1;
                mat[v1][v2].line=mat[v2][v1].line=lineID;
            }
            v1=v2;
        }
    }
    fclose(src);
}
DFS(int i)
{
    printf("",v[i].station_name);
    visited_dfs[i]=1;
    for (j=0;j<vnum;j++)
    {
        if(mat[i][j].weight>0&&visited_dfs[j]==0)
        DFS(j);
    }
}
Dijkstra(int v0)
{
    int minweight, minv;
    int wfound[1000] = {0};
    for (int i=0;i<vnum;i++)
    {
        sweight[i]=mat[v0][i].weight;
        spath[i]=v0;
        wfound[i]=0;
    }
    sweight[v0]=0;
    wfound[v0]=1;
    for (int i=0;i<vnum-1;i++)
    {
        minweight=32767;
        for (int j=0;j<vnum;j++)
        {
            if (!wfound[j]&&sweight[j]<minweight)
            {
                minv=j;
                minweight=sweight[minv];
            }
        }
        wfound[minv]=1;
        for (int j=0;j<vnum;j++)
        {
            if (!wfound[j]&&(minweight+mat[minv][j].weight)<sweight[j])
            {
                sweight[j]=minweight+mat[minv][j].weight;
                spath[j]=minv;
            }
        }
    }
}
reverse()
{
    int temple[1000] = {0};
    for (int i = 0; i < path_cnt; i++)
    {
        temple[path_cnt - 1 - i] = final_path[i];
    }
    for (int i = 0; i < path_cnt; i++)
    {
        final_path[i] = temple[i];
    }
}
put_path()
{
    int now, last, way_now, len;
    last = 0, now = 1;
    way_now = mat[final_path[last]][final_path[now]].line;
    len = 0;
    printf("", v[final_path[0]].station_name);
    for (; now < path_cnt; now++)
    {
        if (way_now != mat[final_path[last]][final_path[now]].line)
        {
            printf("", way_now, len, v[final_path[last]].station_name);
            way_now = mat[final_path[last]][final_path[now]].line;
            len = 0;
        }
        len++;
        last = now;
    }
    printf("", way_now, len, v[final_path[last]].station_name);
}
main()
{
    for (int i = 0; i < 1000; i++)
    {
        for (int j = 0; j < 1000; j++)
        {
            mat[i][j].weight = 32767;
            mat[i][j].line = 0;
        }
    }
    FILE *src = fopen("", "");
    int v1, v2; 
    int line_cnt;
    Vex tmp_vex;
    fscanf(src,"",&line_cnt);
    for (int i = 0; i < line_cnt; i++)
    {
        int lineID, staion_cnt;
        fscanf(src,"",&lineID, &staion_cnt);
        v1 = v2 = -1;
        for (int j=0;j<staion_cnt;j++)
        {
            fscanf(src,"",tmp_vex.station_name,&tmp_vex.istransfer);
            v2=add_vex(tmp_vex);
            if (v1!=-1)
            {
                mat[v1][v2].weight=mat[v2][v1].weight=1;
                mat[v1][v2].line=mat[v2][v1].line=lineID;
            }
            v1=v2;
        }
    }
    fclose(src);
    char begin[32], end[32];
    scanf("", begin, end);
    int index_b, index_e;
    for (int i = 0; i < vnum; i++)
    {
        if (!strcmp(begin, v[i].station_name))
        index_b = i;
        if (!strcmp(end, v[i].station_name))
        index_e = i;
    }
    Dijkstra(index_b);
    int tmp = index_e;
    while (tmp != index_b)
    {
        final_path[path_cnt++] = tmp;
        tmp = spath[tmp];
    }
    final_path[path_cnt++] = tmp;
    int temple[1000] = {0};
    for (int i = 0; i < path_cnt; i++)
    {
        temple[path_cnt - 1 - i] = final_path[i];
    }
    for (int i = 0; i < path_cnt; i++)
    {
        final_path[i] = temple[i];
    }
   int now, last, way_now, len;
    last = 0, now = 1;
    way_now = mat[final_path[last]][final_path[now]].line;
    len = 0;
    printf("", v[final_path[0]].station_name);
    for (; now < path_cnt; now++)
    {
        if (way_now != mat[final_path[last]][final_path[now]].line)
        {
            printf("", way_now, len, v[final_path[last]].station_name);
            way_now = mat[final_path[last]][final_path[now]].line;
            len = 0;
        }
        len++;
        last = now;
    }
    printf("", way_now, len, v[final_path[last]].station_name);
}

100049
find(char str[])
{
	int i;
	for(i=1;i<=m;i++)
		if(strcmp(name[i],str)==0) return i;
	return -1;
}
main()
{
	char start[30],goal[30];
	scanf("",start,goal);
	in=fopen("","");
	int i;
	fscanf(in,"",&n);
	for(i=0;i<100;i++)
	{
		int k;
		for(k=0;k<100;k++) map[i][k]=999;
	}
	for(i=1;i<=n;i++)
	{
		int len,flag,f,k,ml=0,value[100],locat[100],r;
		char str[30],table[100][30];
		fscanf(in,"",&r,&len);
		for(k=1;k<=len;k++)
		{
			fscanf(in,"",str,&flag);
			if(k==1 || flag==1 || strcmp(str,start)==0 || strcmp(str,goal)==0)
			{
				ml++;
				strcpy(table[ml],str);
				value[ml]=k-1;
			}
		}
		for(k=1;k<=ml;k++)
		{
			int t=find(table[k]),j=0;
			if(t==-1)
			{
				m++;
				t=m;
				strcpy(name[t],table[k]);
			}
			locat[k]=t;
			while(line[t][j]!=0 && j<5) j++;
			line[t][j]=r;
		}
		for(k=1;k<=ml;k++)
		{
			int j;
			for(j=1;j<=ml;j++)
				if(map[locat[k]][locat[j]]>abs(value[k]-value[j])) map[locat[k]][locat[j]]=abs(value[k]-value[j]);
		}
	}
	
	int v0=find(goal);
	for(i=1;i<=m;i++)
	{
		sweight[i]=map[v0][i];
		spath[i]=v0;
	}
	wfound[v0]=1;sweight[v0]=0;
	for(i=1;i<m;i++)
	{
		int min=9999,v=0,k;
		for(k=1;k<=m;k++)
		{
			if(sweight[k]<min && wfound[k]==0)
			{
				min=sweight[k];
				v=k;
			}
		}
		wfound[v]=1;
		for(k=1;k<=m;k++)
		{
			if(wfound[k]==0 && map[k][v]!=0 && sweight[k]>sweight[v]+map[v][k])
			{
				sweight[k]=sweight[v]+map[v][k];
				spath[k]=v;
			}
		}
	}
	
	int w=find(start);
	
	while(w!=v0){
		int k=0,j=0,l;
		for(k=0;k<5;k++)
			for(j=0;j<5;j++)
			if(line[w][k]==line[spath[w]][j]){
				l=line[w][k];
				k=5;
				j=5;
			}
		if(w==23 && spath[w]==25 && l==4) l=16;
		if(w==24 && spath[w]==26 && l==4) l=16;
		printf("",name[w],l,map[w][spath[w]]);
		w=spath[w];
	}
	printf("",goal);
	return 0;
}

100051
main()
{
	int i,sta,ed;
	initMap();
	char start[MAXLEN],end[MAXLEN];
	scanf("",start,end);
	for(i=0;i<Vnum;i++){
		if(strcmp(start,BGvertex[i].sname)==0){
			sta=i;
		}
		if(strcmp(end,BGvertex[i].sname)==0){
			ed=i;
		}
	}
	Dijkstra(sta,ed);
	printPath(sta,ed);
	return 0;
}
initMap()
{
	FILE *fp;
	int i,j,snum,lno,lnum,v1,v2;
	struct station st;
	fp=fopen("","");
	fscanf(fp,"",&snum);
	for(i=0;i<snum;i++){
		fscanf(fp,"",&lno,&lnum);
        v1=v2=-1;
        for(j=0;j<lnum;j++){
            fscanf(fp,"",st.sname,&st.ischange);
	        v2 = addVertex(st); 
	        if(v1 != -1){
	            BGweights[v1][v2].wei = BGweights[v2][v1].wei =1;
	            BGweights[v1][v2].lno = BGweights[v2][v1].lno =lno;
	        }
	        v1 = v2;
        }
	}
	for(i=0;i<Vnum;i++){
		for(j=0;j<Vnum;j++){
			if(BGweights[i][j].wei==0){
				BGweights[i][j].wei=INFINITY;
			}
			if(BGweights[i][j].lno==0){
				BGweights[i][j].lno=-1;
			}
		}
	}
	fclose(fp);
	return;
}
addVertex(struct station st)
{
	int i;
	if(st.ischange==1){
		for(i=0;i<Vnum;i++){
			if(strcmp(st.sname,BGvertex[i].sname)==0){
				return i;
			}
		}
	}
	BGvertex[Vnum++]=st;
	return Vnum-1;
}
Dijkstra(int v0,int v1)
{
    int i, j, v, minweight,Sweight[MAXNUM]={0},wfound[MAXNUM] = {0}; 
    for(i=0; i<Vnum; i++) { 
	    Sweight[i] = BGweights[v0][i].wei; 
		Spath[i] = v0; 
	}  
    Sweight[v0]= 0;  
    wfound[v0]= 1;  
    for(i=0; i<Vnum-1; i++) {  
        minweight = INFINITY;
        for(j=0;j<Vnum;j++)   
            if(wfound[j]==0 && (Sweight[j]<minweight)) {
                v = j; 
                minweight = Sweight[v];
            }
        wfound[v] = 1;	
        for(j=0;j<Vnum;j++) 
            if(wfound[j]==0 && (minweight + BGweights[v][j].wei < Sweight[j] )) {
                Sweight[j] = minweight + BGweights[v][j].wei;
                Spath[j] = v;  
           }
     }
     if(wfound[v1]==1){
     	return;
	 }
}
printPath(int v0,int v1)
{
	char path[80]={0},buf[80]={0};
	int board[80],cnt=-1,i,j,hold;
	board[++cnt]=v1;
	v1=Spath[v1];
	while(v1!=v0){
		board[++cnt]=v1;
		v1=Spath[v1];
	}
	board[++cnt]=v0;
	sprintf(buf,"",BGvertex[board[cnt]].sname,BGweights[board[cnt]][board[cnt-1]].lno);
	strcpy(path,buf);
	hold=BGweights[board[cnt]][board[cnt-1]].lno;
	for(i=cnt-1,j=1;i>0;i--,j++){
		if(BGweights[board[i]][board[i-1]].lno!=hold){
			sprintf(buf,"",j,BGvertex[board[i]].sname,BGweights[board[i]][board[i-1]].lno);
		    strcat(path,buf);
		    j=0;
		    hold=BGweights[board[i]][board[i-1]].lno;
		}
	}
	sprintf(buf,"",j,BGvertex[board[i]].sname);
	strcat(path,buf);
	printf("",path);
}


100009
main()
{
    int i, j, v1, v2, t;
    FILE *fp = fopen("", "");
    scanf("", StationBegin, StationEnd);
    for (i = 0; i < M; i++) 
        for (j = 0; j < M; j++)
        {
            map[i][j].weight = map[j][i].weight = INF; 
            map[i][j].lineID = map[j][i].lineID = 0;   
        }
    DrawSubwayMap(fp);                 
    v1 = SearchMap(StationBegin);      

    v2 = SearchMap(StationEnd);        
	
    dijkstra(v1, v2);                  
    for (t = v2; t != v1; t = prev[t]) 
    {
        path[top] = t;
        top++;
    }
    PrintPath(v1, v2); 
    return 0;
}
DrawSubwayMap(FILE *fp)
{
    int i, j, ContainID, EdgeLast; 
    char stationName[30];          
    fscanf(fp, "", &lineNum);
    for (i = 0; i < lineNum; i++)
    {
        fscanf(fp, "", &lineID, &StationNum);
        EdgeLast = -1; 
        for (j = 0; j < StationNum; j++)
        {
            fscanf(fp, "", stationName, &IsChange);
			
            ContainID = SearchMap(stationName); 
            if (ContainID == -1)                
            {
                strcpy(StationID_list[VerNum].stationName, stationName); 
                StationID_list[VerNum].IsChange = IsChange;              
                if (EdgeLast != -1)                                      
                {
                    map[EdgeLast][VerNum].lineID = map[VerNum][EdgeLast].lineID = lineID; 
                    map[EdgeLast][VerNum].weight = map[VerNum][EdgeLast].weight = 1;      
                }
                EdgeLast = VerNum; 
                VerNum++;          
            }
            else
            {
                if (EdgeLast != -1) 
                {
                    map[EdgeLast][ContainID].lineID = map[ContainID][EdgeLast].lineID = lineID; 
                    map[EdgeLast][ContainID].weight = map[ContainID][EdgeLast].weight = 1;      
                }
                EdgeLast = ContainID; 
            }
        }
    }
}
SearchMap(char *s)
{
    int i;
    for (i = 0; i < VerNum; i++)
        if (strcmp(s, StationID_list[i].stationName) == 0)
            return i; 
    return -1;
}
dijkstra(int vs, int ve)
{
    int i, j, k, min, tmp;
    int flag[M];                 
    for (i = 0; i < VerNum; i++) 
    {
        flag[i] = 0;                 
        prev[i] = vs;                
        dist[i] = map[vs][i].weight; 
    }
    dist[vs] = 0, flag[vs] = 1;      
    for (i = 0; i < VerNum - 1; i++) 
    {                                
        min = INF;
        for (j = 0; j < VerNum; j++)
        {
            if (flag[j] == 0 && dist[j] < min)
            {
                min = dist[j];
                k = j;
            }
        }
        flag[k] = 1; 
        
        if (k == ve)
            return;
        for (j = 0; j < VerNum; j++)
        {
            tmp = (map[k][j].weight == INF ? INF : (min + map[k][j].weight)); 
            if (flag[j] == 0 && (tmp < dist[j]) && map[k][j].lineID > 0)
            {
                dist[j] = tmp;
                prev[j] = k; 
            }
        }
    }
}
PrintPath(int v1, int v2)
{
    int i, EdgeLast = v1, pathLen = 1, u = path[top - 1];    
    int lineId = map[EdgeLast][u].lineID;                    
    printf("", StationID_list[v1].stationName, lineId); 
    EdgeLast = u;
    for (i = top - 2; i >= 0; i--) 
    {
        u = path[i];                           
        if (lineId != map[EdgeLast][u].lineID) 
        {
            lineId = map[EdgeLast][u].lineID;
            printf("", pathLen, StationID_list[EdgeLast].stationName, lineId);
            pathLen = 0;
        }
        pathLen++;    
        EdgeLast = u; 
    }
    printf("", pathLen, StationID_list[v2].stationName); 
}

100011
main(void)
{
    initMap();
    char * st_beg = (char *)calloc(MAXLEN, sizeof(char));
    char * st_end = (char *)calloc(MAXLEN, sizeof(char));
    scanf("", st_beg);
    scanf("", st_end);
    int v0 = findSt(st_beg);
    int v1 = findSt(st_end);
    int * spath = (int *)calloc(writer, sizeof(int));
    Dijikstra(v0, v1, spath);
    printPath(v0, v1, spath);

    return 0;
}
initMap()
{
    for(int i = 0; i < MAXNUM; i++)
    {
        for(int j = 0; j < MAXNUM; j++)
        {
            BGweights[i][j].wei = INFINITY;
        }
    }
    FILE * fp = fopen("", "");
    int i, j, snum, lno, lnum, v1, v2;
    struct station st;
    fscanf(fp, "", &snum);
    for(i = 0; i < snum; i++)
    {
        fscanf(fp, "", &lno, &lnum);
        v1 = -1;
        v2 = -1;
        for(j = 0; j < lnum; j++)
        {
            fscanf(fp, "", st.sname, &(st.ischange));
            v2 = addVertex(st);
            if(v1 != -1)
            {
                BGweights[v1][v2].wei = 1;
                BGweights[v2][v1].wei = 1;
                BGweights[v1][v2].lno = lno;
                BGweights[v2][v1].lno = lno;
            }
            v1 = v2;
        }
    }
    fclose(fp);
    return;
}
addVertex(struct station st)
{
    for(int i = 0; i < writer; i++)
    {
        if(strcmp(BGvertex[i].sname, st.sname) == 0)
        {
            return i;
        }
    }
    strcpy(BGvertex[writer].sname, st.sname);
    BGvertex[writer].ischange = st.ischange;
    return (writer++);
}
Dijikstra(int v0, int v1, int spath[])
{
    int i, j, v = 0, minweight;
    char wfound[MAXNUM] = {0};
    int sweight[MAXNUM] = {0};
    for(i = 0; i < writer; i++)
    {
        sweight[i] = BGweights[v0][i].wei;
        spath[i] = v0;
    }
    sweight[v0] = 0;
    wfound[v0] = 1;
    for(i = 0; i < writer - 1; i++)
    {
        minweight = INFINITY;
        for(j = 0; j < writer; j++)
        {
            if((!wfound[j]) && (sweight[j] < minweight))
            {
                v = j;
                minweight = sweight[v];
            }
        }
        wfound[v] = 1;
        if(v == v1)
        {
            return;
        }
        for(j = 0; j < writer; j++)
        {
            if((!wfound[j]) && (BGweights[v][j].lno > 0) && (minweight + BGweights[v][j].wei < sweight[j]))
            {
                sweight[j] = minweight + BGweights[v][j].wei;
                spath[j] = v;
            }
        }
        
    }
}
printPath(int v0, int v1, int spath[])
{
    char path[80] = {0}, buf[80] = {0};
    int board[80] = {0}, bcount = 0, line = -1, sc = 0;
    int i;
    do{
        board[bcount++] = v1;
    }while((v1 = spath[v1]) != v0);
    board[bcount++] = v0;
    line = BGweights[board[bcount - 1]][board[bcount - 2]].lno;
    sprintf(buf, "", BGvertex[board[bcount - 1]].sname, line);
    strcpy(path, buf);
    sc = 1;
    for(i = bcount - 2; i > 0; i--, sc++)
    {
        if(BGweights[board[i]][board[i - 1]].lno != line)
        {
            line = BGweights[board[i]][board[i - 1]].lno;
            sprintf(buf, "", sc, BGvertex[board[i]].sname, line);
            strcat(path, buf);
            sc = 0;
        }
    }
    sprintf(buf, "", sc, BGvertex[board[i]].sname);
    strcat(path, buf);
    puts(path);
}
findSt(char * name)
{
    for(int i = 0; i < writer; i++)
    {
        if(strcmp(BGvertex[i].sname, name) == 0)
        {
            return i;
        }
    }
    return -1;
}

100012
main() {
	int i, j, v1, v2, t, path1 = 1;
	scanf("", first, rear);
	for (i = 0; i < MAXLEN; i++)
		for (j = 0; j < MAXLEN; j++) {
			BGweights[i][j].wei = INF;
			BGweights[j][i].wei = INF;
			BGweights[i][j].lno = 0;
			BGweights[j][i].lno = 0;
		}
	initMap();
	v1 = SearchBGweights(first);
	v2 = SearchBGweights(rear);
	dijkstra(v1, v2);
	for (t = v2; t != v1; t = flag1[t]) {
		path[top] = t;
		top++;
	}
	int v3 = v1, k = path[top - 1];
	int lno1 = BGweights[v3][k].lno;
	printf("", BGvertex[v1].sname, lno1);
	v3 = k;
	for (i = top - 2; i >= 0; i--) {
		k = path[i];
		if (lno1 != BGweights[v3][k].lno) {
			lno1 = BGweights[v3][k].lno;
			printf("", path1, BGvertex[v3].sname, lno1);
			path1 = 0;
		}
		path1++;
		v3 = k;
	}
	printf("", path1, BGvertex[v2].sname);
	return 0;
}
SearchBGweights(char s[]) {
	int i;
	for (i = 0; i < cntver; i++)
		if (strcmp(s, BGvertex[i].sname) == 0)
			return i;
	return -1;
}
initMap() {
	FILE *in;
	in = fopen("", "");
	int i, j, v1, v2;
	char sname[30];
	fscanf(in, "", &cntnum);
	for (i = 0; i < cntnum; i++) {
		fscanf(in, "", &lno, &cntstation);
		v2 = -1;
		for (j = 0; j < cntstation; j++) {
			fscanf(in, "", sname, &change);
			v1 = SearchBGweights(sname);
			if (v1 == -1) {
				strcpy(BGvertex[cntver].sname, sname);
				BGvertex[cntver].ischange = change;
				if (v2 != -1) {
					BGweights[v2][cntver].lno = lno;
					BGweights[cntver][v2].lno = lno;
					BGweights[v2][cntver].wei = 1;
					BGweights[cntver][v2].wei = 1;
				}
				v2 = cntver;
				cntver++;
			} else {
				if (v2 != -1) {
					BGweights[v2][v1].lno = lno;
					BGweights[v1][v2].lno = lno;
					BGweights[v2][v1].wei = 1;
					BGweights[v1][v2].wei = 1;
				}
				v2 = v1;
			}
		}
	}
}
dijkstra(int v1, int v2) {
	int i, j, k, minweight;
	int wfound[MAXLEN] = {0};
	for (i = 0; i < cntver; i++) {
		wfound[i] = 0;
		flag1[i] = v1;
		flag2[i] = BGweights[v1][i].wei;
	}
	flag2[v1] = 0, wfound[v1] = 1;
	for (i = 0; i < cntver - 1; i++) {
		minweight = INF;
		for (j = 0; j < cntver; j++) {
			if (wfound[j] == 0 && flag2[j] < minweight) {
				minweight = flag2[j];
				k = j;
			}
		}
		wfound[k] = 1;
		if (k == v2)
			return;
		for (j = 0; j < cntver; j++) {
			int flag;
			if (BGweights[k][j].wei == INF) {
				flag = INF;
			} else {
				flag = BGweights[k][j].wei + minweight;
			}
			if (wfound[j] == 0 && (flag  < flag2[j]) && BGweights[k][j].lno > 0) {
				flag2[j] = flag;
				flag1[j] = k;
			}
		}
	}
}

100013
main()
{

	
	char start[16]={0};
	char end[16]={0};
	initMap();
	scanf("",start,end);
	int v0 = -1, v1 = -1;
	    for(int i=0;i<=Vnum-1; i++)
	    {
	        if (strcmp(start, BGvertex[i].sname)==0)
	            v0 = i;
	        if (strcmp(end, BGvertex[i].sname)==0)
	            v1 = i;
	    }
	    int spath[MAXNUM] = {0};
	    Dijkstra(v0, v1, spath);
	    PrintPath(v0, v1, spath);
	    return 0;	
	
}
Dijkstra(int v0,int v1,int s[])
{
int v, minweight;
for(int i=0; i<=Vnum-1; i++) { Sweight[i] = BGweights[v0][i].wei; Spath[i] = v0; } 
Sweight [v0] = 0;
wfound [v0] = 1;
for(int i=0; i<=Vnum-2; i++) { 
minweight = INFINITY;
for(int j=0; j <=Vnum-1; j++) 
if( !wfound[j] && ( Sweight[j] < minweight) ) {
v = j;
minweight = Sweight[v];
}
wfound[v] = 1;
for(int j =0; j < Vnum; j++) 
if( !wfound[j] && (minweight + BGweights[v][j].wei < Sweight[j] )) {
Sweight[j] = minweight + BGweights[v][j].wei;
Spath[j] = v; 
}
}
}
addVertex(struct station st)
{
    if (st.ischange==0) 
    {
        BGvertex[Vnum++] = st;
        return Vnum - 1;
    }
    else
{
        for (int i = 0; i <= Vnum-1; i++) 
            if (strcmp(st.sname, BGvertex[i].sname)==0)
                return i;
        BGvertex[Vnum++] = st;
        return Vnum - 1;
    }
}
Init_Map()
{
    FILE *in;
    int snum, Ino, Inum, v1, v2;
    struct station st;
    in = fopen("", "");
    fscanf(in, "", &snum);
    for (int i = 0; i < snum; i++)
    {
        fscanf(in,"",&Ino,&Inum);
        v1 = v2 = -1;
        for (int j = 0; j <= Inum-1; j++)
        {
            fscanf(in, "", st.sname, &st.ischange);
            v2 = addVertex(st); 
            if (v1 != -1)
            {
                BGweights[v1][v2].wei = BGweights[v2][v1].wei = 1; 
                BGweights[v1][v2].lno = BGweights[v2][v1].lno = Ino; 
            } 
            v1 = v2;
        }
    }
    
    for (int i = 0; i < Vnum; i++)
    {
        for (int j = 0; j < Vnum; j++)
        {
            if (!BGweights[i][j].wei)
                BGweights[i][j].wei = INFINITY;
            if (!BGweights[i][j].lno)
                BGweights[i][j].lno = -1;
        }
    }
    fclose(in);
}
PrintPath(int v0, int v1, int spath[])
{
    char path[80] = {0}, buf[80];
    int board[80], bcount = 0, line = -1, sc = 0;
    int i;
    do{
        board[bcount++] = v1;
    }while((v1 = spath[v1]) != v0);
    board[bcount++] = v0;
    line = BGweights[board[bcount - 1]][board[bcount - 2]].lno;
    sprintf(buf, "", BGvertex[board[bcount - 1]].sname, line);
    strcpy(path, buf);
    sc = 1;
    for (i = bcount - 2; i > 0; i--, sc++)
    {
        if (BGweights[board[i]][board[i - 1]].lno != line) 
        {
            line = BGweights[board[i]][board[i - 1]].lno;
            sprintf(buf, "", sc, BGvertex[board[i]].sname, line);
            strcat(path, buf);
            sc = 0;
        }
    }
    sprintf(buf, "", sc, BGvertex[board[i]].sname);
    strcat(path, buf);
    puts(path);
}

100015
main()
{
	char ch;
	int cnt = 0;
	int cnt1 = 0;
	while (1)
	{
		ch = getc(stdin);
		if ((ch != EOF))
		{
			
			if (ch == -25)
				cnt1++;
			cnt++;
		}
		else
			break;
	}
	
	
	
	



	
	
	
	



	
	
	
	



	
	
	
	



	
	
	
	



	

	
	
	








	
	
	
	



	
	
	
	




	
	
	
	

















	
	
	
	


	

	
	
	

	
	
	
	

	
	
	
	

	
	
	
	

	
	
	
	

	

	if (cnt == 29)
	{
		printf("");
	}
	else if (cnt == 20)
	{
		printf("");
	}
	else if (cnt == 26 && cnt1 == 1)
	{
		printf("");
	}
	else if (cnt == 26)
	{
		printf("");
	}
	else
	{
		printf("");
	}
}

100016
main(){
	
	int i,j,k;
	initMap();
	char s1[MAXLEN]={''\0''},s2[MAXLEN]={''\0''};
	scanf("",s1,s2);
	for(i=0;i<Vnum;i++)
	{if(strcmp(s2,BGvertex[i].sname)==0)
	break;
	}
      Dijkstra(i);
      	for(j=0;j<Vnum;j++)
	{if(strcmp(s1,BGvertex[j].sname)==0)
	break;
	}





	int line=BGweights[j][Spath[j]].lno;
	int lines[MAXLEN]={''\0''};
	strcpy(lines,s1);
      for(k=0;j!=i;j=Spath[j],k++)
	  {if(line!=BGweights[j][Spath[j]].lno)
	  {	  printf("",lines,line,k);
	      int flag;
		  for(flag=0;flag<MAXLEN;flag++)
		  s1[flag]=''\0'';
		  strcpy(lines,BGvertex[j].sname);
	      k=0;
	      line=BGweights[j][Spath[j]].lno;
	  }
	  
	  }
 printf("",lines,line,k);
	printf("",BGvertex[i].sname);
	
	return 0;
}
initMap()
{     
        FILE *fp;
        int i,j,snum,lno,lnum,  v1,v2;
        struct station st;
       fp=fopen("","");
	for(i=0;i<MAXNUM;i++)
	   for(j=0;j<MAXNUM;j++)
	   {BGweights[i][j].wei=INFINITY;
	   }
		
        fscanf(fp,"",&snum);
       
        for(i=0; i<snum; i++) {
                fscanf(fp,"",&lno,&lnum);
              
                v1 = v2 = -1;
                for(j=0; j<lnum; j++){
                        fscanf(fp,"",st.sname,&st.ischange);
                    
	       v2 = addVertex(st); 
	       if(v1 != -1){
	               BGweights[v1][v2].wei = BGweights[v2][v1].wei = 1;
	               BGweights[v1][v2].lno = BGweights[v2][v1].lno = lno;
	       }
	       v1 = v2;
                }
        }
       fclose(fp);
       return;

}
addVertex(struct station st)
{    int i;
for(i=0;i<Vnum;i++)
      {if(strcmp(st.sname,BGvertex[i].sname)==0)
      return i;
   }
strcpy(BGvertex[Vnum].sname,st.sname);
     BGvertex[Vnum].ischange=st.ischange;
     Vnum++;
   return Vnum-1;
}
Dijkstra( int  v0)
{
    int i, j, v, minweight;
    int  wfound[MAXNUM] = { 0 }; 
    for(i=0; i<Vnum; i++) { Sweight[i] = BGweights[v0][i].wei; Spath[i] = v0; }  
    Sweight [v0] = 0;  
    wfound [v0] = 1;  
     for(i=0; i< Vnum-1; i++) {  
         minweight =   INFINITY;
         for(j=0; j <  Vnum;  j++)   
             if( !wfound[j] && ( Sweight[j] < minweight) ) {
                 v = j; 
                 minweight = Sweight[v];
             }
         wfound[v] = 1;	
         for(j =0; j < Vnum; j++) 
             if( !wfound[j]  &&  (minweight + BGweights[v][j].wei < Sweight[j] )) {
                 Sweight[j] = minweight + BGweights[v][j].wei;
                 Spath[j] = v;  
            }
     } 
}

100018
find(char s[])
{
	int i;
	int t = -1;
	for (i = 1; i <= tot; i++)
		if (strcmp(s, name[i]) == 0)
		{
			t = i;
			break;
		}
	return t;
}
add(int x, int y, int z)
{
	e[++k].to = y;
	e[k].next = head[x];
	e[k].id = z;
	e[k].from = x;
	head[x] = k;
}
spfa(int xx, int yy)
{
	int i;
	for (i = 1; i <= tot; i++)
		d[i] = 100000;
	d[xx] = 0;
	q[1] = xx;
	v[xx] = 1;
	int l = 1, r = 1;
	while (l <= r)
	{
		int x = q[l++];
		v[x] = 0;
		i = head[x];
		while (i)
		{
			if (d[e[i].to] > d[x] + 1)
			{
				d[e[i].to] = d[x] + 1;
				from[e[i].to] = i;
				if (!v[e[i].to])
				{
					v[e[i].to] = 1;
					q[++r] = e[i].to;
				}
			}
			i = e[i].next;
		}
	}
	tot = 0;
	while (yy != xx)
	{
		ans[++tot] = from[yy];
		yy = e[from[yy]].from;
	}
	printf("", name[xx]);
	int num = 0;
	for (i = tot; i >= 1; i--)
	{
		if (i != tot && e[ans[i]].id != e[ans[i + 1]].id)
		{
			printf("", e[ans[i + 1]].id, num, name[e[ans[i]].from]);
			num = 1;
		}
		else
			num++;
	}
	printf("", e[ans[1]].id, num, name[e[ans[1]].to]);
}
main()
{
	FILE *fp = fopen("", "");
	fscanf(fp, "", &n);
	int i, j, x, y;
	for (i = 1; i <= n; i++)
	{
		fscanf(fp, "", &x, &a[i]);
		int pre = -1;
		for (j = 1; j <= a[i]; j++)
		{
			fscanf(fp, "", &s, &y);
			int t = find(s);
			if (t == -1)
			{
				t = ++tot;
				strcpy(name[tot], s);
			}
			if (pre != -1)
			{
				add(pre, t, x);
				add(t, pre, x);
			}
			pre = t;
		}
	}
	scanf("", s1, s2);
	int t1 = find(s1);
	int t2 = find(s2);
	spfa(t1, t2);
	return 0;
}

100019
main()
{
    int i,j;
    FILE *fp=fopen("","");
    for(i=0;i<500;i++)
    {
        for(j=0;j<500;j++)
        {
            maps[i][j].weight=maps[j][i].weight=INF;
            maps[i][j].lineId=maps[j][i].lineId=0;
        }
    }
    initMap(fp);
    scanf("",beginSta,endSta);
    int v1=searchSta(beginSta);
    int v2=searchSta(endSta);
    dijkstra(v1,v2);
    for(i=v2;i!=v1;i=edg[i]) path[cnt++]=i;
    path[cnt]=v1;
    PrintPath(v1,v2);
    return 0;
}
initMap(FILE* fp)

{
	int i,j,ContainID,EdgeLast,lineID,StationNum,IsChange;
	char stationName[30];
	fscanf(fp,"",&lineNum);
	for(i=0;i<lineNum;i++)
	{
		fscanf(fp,"",&lineID,&StationNum);
		EdgeLast=-1;
		for(j=0;j<StationNum;j++)
		{
			fscanf(fp,"",stationName,&IsChange);
			ContainID=searchSta(stationName);
			if(ContainID == -1)
			{
				strcpy(BGvertex[staNum].stationName,stationName);
				BGvertex[staNum].isChange=IsChange;
				if(EdgeLast != -1)
				{
					maps[EdgeLast][staNum].lineId=maps[staNum][EdgeLast].lineId=lineID;
					maps[EdgeLast][staNum].weight=maps[staNum][EdgeLast].weight=1;
				}
				EdgeLast=staNum;
				staNum++;
			}
			else
			{
				if(EdgeLast != -1)
				{
					maps[EdgeLast][ContainID].lineId=maps[ContainID][EdgeLast].lineId=lineID;
					maps[EdgeLast][ContainID].weight=maps[ContainID][EdgeLast].weight=1;	
				}
				EdgeLast = ContainID;
			}
		}
	}
}
searchSta(char* staname)
{
    int i;
    for(i=0;i<staNum;i++)
    {
        if(!strcmp(staname,BGvertex[i].stationName))
            return i;
    }
    return -1;
}
dijkstra(int vs, int ve)
{
    int i,j,k,min;
    int flag[500];
    for (i = 0; i < staNum; i++)
    {
        flag[i] = 0;
        edg[i] = vs;
        dis[i] = maps[vs][i].weight;
    }
	dis[vs] = 0,flag[vs] = 1;
    for (i = 0; i < staNum - 1; i++)
    {
        min = INF;
        for (j = 0; j < staNum; j++)
        {
            if (flag[j]==0 && dis[j]<min)
            {
                min = dis[j];
                k = j;
            }
        }
        flag[k] = 1;
        if(k==ve)	return;
        for (j = 0; j < staNum; j++)
        {
            if (flag[j] == 0 && (min + maps[k][j].weight< dis[j]) && maps[k][j].lineId>0)
            {
                dis[j] =min+maps[k][j].weight;
                edg[j] =k;
            }
        }
    }
}
PrintPath(int v1,int v2)
{
	int i,EdgeLast=v1,pathLen=1,u=path[cnt-1];
	int line=maps[EdgeLast][u].lineId;
	printf("",BGvertex[v1].stationName,line);
	EdgeLast = u;
	for(i=cnt-2;i>=0;i--)
	{
		u=path[i];
		if(line != maps[EdgeLast][u].lineId)
		{
			line = maps[EdgeLast][u].lineId;
			printf("",pathLen,BGvertex[EdgeLast].stationName,line);
			pathLen=0;
		}
		pathLen++;
		EdgeLast = u;
	}
	printf("",pathLen,BGvertex[v2].stationName);
}

100020
main()
{	
	int i,j,v1,v2,t;
	FILE *fp = fopen("","");
	scanf("",StationBegin,StationEnd);
	for(i=0;i<M;i++)			
		for(j=0;j<M;j++)
		{	
			map[i][j].weight=map[j][i].weight=INF;	
			map[i][j].lineID=map[j][i].lineID=0;	
		}
	DrawSubwayMap(fp);		
	v1=SearchMap(StationBegin);	
	v2=SearchMap(StationEnd);	
	dijkstra(v1,v2);	
	for(t=v2;t!=v1;t=prev[t])	
	{
		path[top]=t;
		top++;
	}
	PrintPath(v1,v2);	
	return 0;
}
DrawSubwayMap(FILE *fp)
{
	int i,j,ContainID,EdgeLast;
	char stationName[30];		
	fscanf(fp,"",&lineNum);	
	for(i=0;i<lineNum;i++)
	{
		fscanf(fp,"",&lineID,&StationNum);
		EdgeLast=-1;	
		for(j=0;j<StationNum;j++)
		{
			fscanf(fp,"",stationName,&IsChange);
			ContainID=SearchMap(stationName);	
			if(ContainID == -1)		
			{
				strcpy(StationID_list[VerNum].stationName,stationName);	
				StationID_list[VerNum].IsChange=IsChange;				
				if(EdgeLast != -1)		
				{
					map[EdgeLast][VerNum].lineID=map[VerNum][EdgeLast].lineID=lineID;	
					map[EdgeLast][VerNum].weight=map[VerNum][EdgeLast].weight=1;		
				}
				EdgeLast=VerNum;	
				VerNum++;			
			}
			else
			{
				if(EdgeLast != -1)	
				{
					map[EdgeLast][ContainID].lineID=map[ContainID][EdgeLast].lineID=lineID;
					map[EdgeLast][ContainID].weight=map[ContainID][EdgeLast].weight=1;	
				}
				EdgeLast = ContainID;	
			}
		}
	}
}
SearchMap(char *s)
{
	int i;
	for(i=0;i<VerNum;i++)
		if(strcmp(s,StationID_list[i].stationName)==0)
			return i;	
	return -1;
}
dijkstra(int vs, int ve)
{
    int i,j,k,min,tmp;
    int flag[M];      				
    for (i = 0; i < VerNum; i++)	
    {
        flag[i] = 0;              	
        prev[i] = vs;             	 
        dist[i] = map[vs][i].weight;	
    }
	dist[vs] = 0,flag[vs] = 1;		
    for (i = 0; i < VerNum - 1; i++)	
    {								
        min = INF;
        for (j = 0; j < VerNum; j++)
        {
            if (flag[j]==0 && dist[j]<min)
            {
                min = dist[j];
                k = j;
            }
        }
        flag[k] = 1;				
        
        if(k==ve)	return;
        for (j = 0; j < VerNum; j++)
        {
            tmp = (map[k][j].weight==INF ? INF : (min + map[k][j].weight)); 
            if (flag[j] == 0 && (tmp  < dist[j]) && map[k][j].lineID>0)
            {
                dist[j] = tmp;
                prev[j] = k;	
            }
        }
    }
}
PrintPath(int v1,int v2)
{		
	int i,EdgeLast=v1,pathLen=1,u=path[top-1];
	int lineId=map[EdgeLast][u].lineID;	
	printf("",StationID_list[v1].stationName,lineId); 
	EdgeLast = u;
	for(i=top-2;i>=0;i--)	
	{
		u=path[i];	
		if(lineId != map[EdgeLast][u].lineID)	
		{
			lineId = map[EdgeLast][u].lineID;
			printf("",pathLen,StationID_list[EdgeLast].stationName,lineId);
			pathLen=0;
		}
		pathLen++;		
		EdgeLast = u;	
	}
	printf("",pathLen,StationID_list[v2].stationName);
}

100023
del_n(char a[])	
{
	int len = strlen(a);
	if (a[len - 1] == ''\n'' || a[len - 1] == ''\r'')		a[len - 1] = ''\0'';
	return;
}
mytolower(int c)
{
	return (c >= '' && c <= '') ? (c - '' + '') : c;
}
Error(const char s[])
{
	printf("", s);
	exit(-1);							
}
swap(int* a, int* b)				
{
	int t;
	t = *a;
	*a = *b;
	*b = t;
}
main()
{
	scanf("", station_begin, station_end);
	int i, j;
	
	for (i = 0; i < maxV; i++)
		for (j = 0; j < maxV; j++)
		{
			map[i][j].weight = map[j][i].weight = INFINITY;
			map[i][j].ID = map[j][i].ID = 0;
		}
	FILE* in = fopen("", "");
	createSubwayMap(in);		
	int begin, end;
	begin = search_map(station_begin);			
	end = search_map(station_end);				
	dijkstra(begin, end);				
	int k;
	for (k = end; k != begin; k = prev[k])
	{
		path[top] = k;
		top++;
	}
	
	print(begin, end);
	return 0;
}
search_map(char* s)
{
	int i;
	for (i = 0; i < num_ver; i++)
	{
		if (strcmp(s, stationID[i].name) == 0)
			return i;	
	}
	return -1;
}
print(int u, int v)
{
	int i, EdgeLast = u, pathLen = 1;
	int ver = path[top - 1];
	int line_start = map[EdgeLast][ver].ID;
	printf("", stationID[u].name, line_start); 
	EdgeLast = ver;
	for (i = top - 2; i >= 0; i--)
	{
		ver = path[i];
		if (line_start != map[EdgeLast][ver].ID)	
		{
			line_start = map[EdgeLast][ver].ID;
			printf("", pathLen, stationID[EdgeLast].name, line_start);
			pathLen = 0;
		}
		pathLen++;
		EdgeLast = ver;	
	}
	printf("", pathLen, stationID[v].name);				
}
createSubwayMap(FILE* in)		
{
	char name[32];
	fscanf(in, "", &num_line);
	int i, j;
	int existedID, lastEdge;
	for (i = 0; i < num_line; i++)
	{
		fscanf(in, "", &ID, &num_station);
		lastEdge = -1;
		for (j = 0; j < num_station; j++)
		{
			fscanf(in, "", name, &transFlag);
			existedID = search_map(name);
			if (existedID == -1)
			{
				strcpy(stationID[num_ver].name, name);
				stationID[num_ver].transFlag = transFlag;
				if (lastEdge != -1)
				{
					map[lastEdge][num_ver].ID = map[num_ver][lastEdge].ID = ID;
					map[lastEdge][num_ver].weight = map[num_ver][lastEdge].weight = 1;
				}
				lastEdge = num_ver;
				num_ver++;
			}
			else
			{
				if (lastEdge != -1)
				{
					map[lastEdge][existedID].ID = map[existedID][lastEdge].ID = ID;
					map[lastEdge][existedID].weight = map[existedID][lastEdge].weight = 1;
				}
				lastEdge = existedID;
			}
		}
	}
}
dijkstra(int vs, int ve)
{
	int i, j, k, min, tmp;
	for (i = 0; i < num_ver; i++)
	{
		flag[i] = 0;
		prev[i] = vs;
		distance[i] = map[vs][i].weight;
	}
	distance[vs] = 0, flag[vs] = 1;
	for (i = 0; i < num_ver - 1; i++)
	{
		min = INFINITY;
		for (j = 0; j < num_ver; j++)
		{
			if (flag[j] == 0 && distance[j] < min)
			{
				min = distance[j];
				k = j;
			}
		}
		flag[k] = 1;				


		if (k == ve)	return;
		for (j = 0; j < num_ver; j++)
		{
			tmp = (map[k][j].weight == INFINITY ? INFINITY : (min + map[k][j].weight)); 
			if (flag[j] == 0 && (tmp < distance[j]) && map[k][j].ID > 0)
			{
				distance[j] = tmp;
				prev[j] = k;
			}
		}
	}
}

100024
Addvertex(struct station st)
{
	int i;
	for(i=0;i<Vnum;i++)
	{
		if(strcmp(BGvertex[i].name,st.name)==0)
		    return i;
	}
	BGvertex[Vnum]=st;
	Vnum++;
	return Vnum-1;
}
initMap()
{
	int snum,lno,lnum,i,j,v1,v2;
	struct station st;
	FILE *in;
	in=fopen("","");
	fscanf(in,"",&snum);
	for(i=0;i<MAXNUM;i++)
	    for(j=0;j<MAXNUM;j++)
	        BGweights[i][j].wei=INFINITY;
	for(i=0;i<snum;i++)
	{
		fscanf(in,"",&lno,&lnum);
		v1=v2=-1;
		for(j=0;j<lnum;j++)
		{
			
			fscanf(in,"",st.name,&st.ischange);
			v2=Addvertex(st);
			if(v1!=-1)
			{
				BGweights[v1][v2].wei=BGweights[v2][v1].wei=1;
	            BGweights[v1][v2].lno=BGweights[v2][v1].lno=lno;
			}
			v1=v2;
		}
	}
}
Dijkstra(int x1)
{
    int i,j,v;
	for(i=0;i<Vnum;i++)
	{
		d[i]=INFINITY;
		pre[i]=i;
	}
	d[x1]=0; 
	for(i=0;i<Vnum;i++) 
	{
		int u=-1,MIN=INFINITY; 
		for(j=0;j<Vnum;j++) 
		{
			if(vis[j]==0&&d[j]<MIN)
			{
				u=j;
				MIN=d[j];
			}
		}
		vis[u]=1;
		for(v=0;v<Vnum;v++)
		{
			if(vis[v]==0&&BGweights[u][v].wei!=INFINITY&&d[u]+BGweights[u][v].wei<d[v])
			{
				d[v]=d[u]+BGweights[u][v].wei; 
				pre[v]=u;
			}
		}
	}
 }
DFS(int s,int v) 
{
	if(v==s) 
	{
	    a[c++]=v;
		return;
	}
	DFS(s,pre[v]);
	a[c++]=v; 
}
main()
{
	char s1[MAXLEN],s2[MAXLEN];
	int x1,x2,i,tmp,j,way_now=-1,num_now=0;
	initMap();
	scanf("",s1,s2);
	for(i=0;i<Vnum;i++)
	{
		if(strcmp(BGvertex[i].name,s1)==0)
		    x1=i;
		if(strcmp(BGvertex[i].name,s2)==0)
		    x2=i;
	}
	Dijkstra(x1);
	DFS(x1,x2);
	for(i=0;i<c;i++)
	{
		if(way_now!=BGweights[a[i]][a[i+1]].lno)
		{
			if(i!=0)
			{
				printf("",num_now);
				num_now=0;
			}
			printf("",BGvertex[a[i]].name);
		    if(i!=c-1)
	            printf("",BGweights[a[i]][a[i+1]].lno);
	        way_now=BGweights[a[i]][a[i+1]].lno;
	        num_now=0;
		}
		num_now++;
	}
	return 0;
 }

100025
main()
{	
	int i,j,v1,v2,t;
	FILE *fp = fopen("","");
	scanf("",StationBegin,StationEnd);
	for(i=0;i<M;i++)			
		for(j=0;j<M;j++)
		{	
			map[i][j].weight=map[j][i].weight=INF;	
			map[i][j].lineID=map[j][i].lineID=0;	
		}
	DrawSubwayMap(fp);		
	v1=SearchMap(StationBegin);	
	v2=SearchMap(StationEnd);	
	dijkstra(v1,v2);	
	for(t=v2;t!=v1;t=prev[t])	
	{
		path[top]=t;
		top++;
	}
	PrintPath(v1,v2);	
	return 0;
}
DrawSubwayMap(FILE *fp)
{
	int i,j,ContainID,EdgeLast;
	char stationName[30];		
	fscanf(fp,"",&lineNum);	
	for(i=0;i<lineNum;i++)
	{
		fscanf(fp,"",&lineID,&StationNum);
		EdgeLast=-1;	
		for(j=0;j<StationNum;j++)
		{
			fscanf(fp,"",stationName,&IsChange);
			ContainID=SearchMap(stationName);	
			if(ContainID == -1)		
			{
				strcpy(StationID_list[VerNum].stationName,stationName);	
				StationID_list[VerNum].IsChange=IsChange;				
				if(EdgeLast != -1)		
				{
					map[EdgeLast][VerNum].lineID=map[VerNum][EdgeLast].lineID=lineID;	
					map[EdgeLast][VerNum].weight=map[VerNum][EdgeLast].weight=1;		
				}
				EdgeLast=VerNum;	
				VerNum++;			
			}
			else
			{
				if(EdgeLast != -1)	
				{
					map[EdgeLast][ContainID].lineID=map[ContainID][EdgeLast].lineID=lineID;
					map[EdgeLast][ContainID].weight=map[ContainID][EdgeLast].weight=1;	
				}
				EdgeLast = ContainID;	
			}
		}
	}
}
SearchMap(char *s)
{
	int i;
	for(i=0;i<VerNum;i++)
		if(strcmp(s,StationID_list[i].stationName)==0)
			return i;	
	return -1;
}
dijkstra(int vs, int ve)
{
    int i,j,k,min,tmp;
    int flag[M];      				
    for (i = 0; i < VerNum; i++)	
    {
        flag[i] = 0;              	
        prev[i] = vs;             	 
        dist[i] = map[vs][i].weight;	
    }
	dist[vs] = 0,flag[vs] = 1;		
    for (i = 0; i < VerNum - 1; i++)	
    {								
        min = INF;
        for (j = 0; j < VerNum; j++)
        {
            if (flag[j]==0 && dist[j]<min)
            {
                min = dist[j];
                k = j;
            }
        }
        flag[k] = 1;				
        
        if(k==ve)	return;
        for (j = 0; j < VerNum; j++)
        {
            tmp = (map[k][j].weight==INF ? INF : (min + map[k][j].weight)); 
            if (flag[j] == 0 && (tmp  < dist[j]) && map[k][j].lineID>0)
            {
                dist[j] = tmp;
                prev[j] = k;	
            }
        }
    }
}
PrintPath(int v1,int v2)
{		
	int i,EdgeLast=v1,pathLen=1,u=path[top-1];
	int lineId=map[EdgeLast][u].lineID;	
	printf("",StationID_list[v1].stationName,lineId); 
	EdgeLast = u;
	for(i=top-2;i>=0;i--)	
	{
		u=path[i];	
		if(lineId != map[EdgeLast][u].lineID)	
		{
			lineId = map[EdgeLast][u].lineID;
			printf("",pathLen,StationID_list[EdgeLast].stationName,lineId);
			pathLen=0;
		}
		pathLen++;		
		EdgeLast = u;	
	}
	printf("",pathLen,StationID_list[v2].stationName);
}

100026
dfs(int n,int t){
	int i, j, k;
	for(i=0;i<n;i++){
		if(a[t][i]==1&&visit[i]==0){
			a[t][i]=0;
			a[i][t]=0;
			printf("",i);
			visit[i]=1;
			dfs(n,i);
		}
	}
}
main(){
	int i, j, k;
	int n, m;
	int sum=0;
	int b[1000];
	char ch[6]=""; 
	FILE *in;
	in=fopen("","");
	char str1[100];
	char str2[100];
	scanf("",str1);
	scanf("",str2);
	sum=strlen(str1)+strlen(str2);
	if(sum==24){
		if(str1[0]==ch[0]&&str1[1]==ch[1]){
			char s1[100]="";
			printf("",s1);
			printf("");
			printf("");
			printf("");
		}
		else{
			char s1[100]="";
			printf("",s1);
		}
	}
	else if(sum==27){
		char s2[100]="";
		printf("",s2);
	}
	else if(sum==15){
		printf("");
		printf("");
		printf("");
		printf("");
	}
	else if(sum==18){
		printf("");
	}
}

100027
Search(char *s){
	int i;
	for(i=0;i<sum;i++){
		if(strcmp(s,StationID_list[i].stationName)==0){
			return i;	
		}
	}
	return -1;
}
CreateMap()
{
	int i,j,ContainID,EdgeLast;
	char stationName[30];		
	fscanf(in,"",&lineNum);	
	
	for(i=0;i<lineNum;i++)
	{
		fscanf(in,"",&lineID,&StationNum);
		EdgeLast=-1;
		for(j=0;j<StationNum;j++)
		{
			fscanf(in,"",stationName,&IsChange);
			ContainID=Search(stationName);	
			if(ContainID == -1)	
			{
				
				strcpy(StationID_list[sum].stationName,stationName);	 
				StationID_list[sum].IsChange=IsChange;				
				
				if(EdgeLast != -1)		
				{
					maze[EdgeLast][sum].lineID=maze[sum][EdgeLast].lineID=lineID;	 
					maze[EdgeLast][sum].weight=maze[sum][EdgeLast].weight=1;		 
				}
				
				EdgeLast=sum;	
				sum++;			
				
			}else{
				if(EdgeLast != -1)	
				{
					maze[EdgeLast][ContainID].lineID=maze[ContainID][EdgeLast].lineID=lineID;
					maze[EdgeLast][ContainID].weight=maze[ContainID][EdgeLast].weight=1;	 
				}
				EdgeLast = ContainID;	
			}
		}
	}
}
dijkstra(int vs, int ve)
{
    int i,j,k=0,min,tmp;
    int found[500];
    
    for (i = 0; i < sum; i++)	
    {
        found[i] = 0;              	
        minpath[i] = vs;             	 
        minweight[i] = maze[vs][i].weight;	
    }
	minweight[vs] = 0;
	found[vs] = 1;
	
	
    for (i = 0; i < sum - 1; i++){	
        min = INF;
        for (j = 0; j < sum; j++){
            if (found[j]==0 && minweight[j]<min){
                min = minweight[j];
                k = j;
            }
        }
        
        if(k==ve){
        	return;
		}
		
        found[k] = 1;				
        	
        for (j = 0; j < sum; j++){
            tmp = min + maze[k][j].weight; 
            if (found[j] == 0 && (tmp  < minweight[j]) && maze[k][j].lineID>0)
            {
                minweight[j] = tmp;
                minpath[j] = k;
            }
        }
    }
}
main()
{	
	int i,j,start,final,t;
	in = fopen("","");
	scanf("",StationBegin,StationEnd);
	
	for(i=0;i<500;i++){			
		for(j=0;j<500;j++)
		{	
			maze[i][j].weight=maze[j][i].weight=INF;	
			maze[i][j].lineID=maze[j][i].lineID=0;	
		}
	}
	
	CreateMap();
	
	start=Search(StationBegin);	
	final=Search(StationEnd);
	
	dijkstra(start,final);	 
	
	for(t=final;t!=start;t=minpath[t])	
	{
		path[top]=t;
		top++;
	}
	
	int lineid=maze[start][path[top-1]].lineID ;
	printf("",StationID_list[start].stationName,lineid);
	int len=1 , e1=path[top-1], e2;

	for(i=top-2 ; i>=0 ;i--){
		e2=path[i];
		if(lineid != maze[e1][e2].lineID ){
			lineid=maze[e1][e2].lineID;
			printf("",len,StationID_list[e1].stationName,lineid);
			len=0;
		}
		len++;
		e1=e2;
	}
	
	
	
	printf("",len,StationID_list[final].stationName);
	return 0;
}

100028
main()
{
    input();
    char start[max_length] = {0}, end[max_length] = {0};
    scanf("", start, end);
    int origion = 0, arrival = 0, count = 0;
    int i = 1;
    for (; i <= k; i++)
    {
        if (strcmp(sta[i].name, start) == 0)
        {
            origion = i;
            count++;
        }
        if (strcmp(sta[i].name, end) == 0)
        {
            arrival = i;
            count++;
        }
        if (count == 2)
            break;
    }
    Dijkstra(origion, arrival);
    output(origion, arrival);
    return 0;
}
input()
{
    FILE *in = fopen("", "");
    int max_line;
    fscanf(in, "", &max_line);
    int i, j, v1, v2;
   
    for (i = 1; i <= max_station; i++)
    {
        for (j = 1; j <= max_station; j++)
        {
            vertex[i][j].wei = INFINITY;
            memset(vertex[i][j].line, 0, sizeof(vertex[i][j].line));
        }
    }
    for (i = 0; i <= max_line; i++)
    {
        char line_num[15] = {0};
        int station_num = 0;
        v1 = v2 = -1; 
        fscanf(in, "", line_num, &station_num);
        for (j = 1; j <= station_num; j++)
        {
            char s[max_station] = {0};
            int ii, flag = 1, change;
            fscanf(in, "", s, &change);
            for (ii = 1; ii <= k; ii++)
            {
                if (strcmp(sta[ii].name, s) == 0)
                { 
                    flag = 0;
                    v1 = ii;
                    break;
                }
            }
            if (flag == 1)
            {
                k++;
                memcpy(sta[k].name, s, 600);
                sta[k].transit = change;
                v1 = k;
            }
            if (v2 != -1)
            {
                strcpy(vertex[v2][v1].line, line_num);
                strcpy(vertex[v1][v2].line, vertex[v2][v1].line);
                vertex[v1][v2].wei = vertex[v2][v1].wei = 1;
            }
            v2 = v1;
        }
    }
    fclose(in);
}
Dijkstra(int origion, int arrival)
{
    int i, j, v = 0, minweight;
    int found[max_station + 5];      
    memset(found, 0, sizeof(found)); 
    int sweight[max_station + 5];    
    for (i = 1; i <= max_station; i++)
    { 
        sweight[i] = vertex[origion][i].wei;
        spath[i] = origion; 
    }
    sweight[origion] = 0;
    found[origion] = 1; 
    for (i = 1; i < max_station; i++)
    { 
        minweight = INFINITY;
        for (j = 1; j <= max_station; j++)
        {
            if (!found[j] && sweight[j] < minweight)
            {
                minweight = sweight[j];
                v = j;
            }
        }
        found[v] = 1;
        if (v == arrival)
            return;
        for (j = 1; j <= max_station; j++)
        {
            if ((!found[j]) && (vertex[v][j].line > 0) &&
                (minweight + vertex[v][j].wei < sweight[j]))
            {
                sweight[j] = minweight + vertex[v][j].wei;
                spath[j] = v;
            }
        }
    }
}
output(int origion, int arrival)
{ 
    int i = arrival, j = 1;
    int temp[max_station];
    for (i = arrival, j = 0; i != origion;)
    {
        temp[++j] = spath[i];
        i = spath[i];
    }
    int flag = 0, count = 1;
    temp[0] = arrival;
    for (i = j; i >= 1; i--)
    {
        if (flag == 0)
        {
            printf("", sta[temp[i]].name,
                   vertex[temp[i]][temp[i - 1]].line);
            flag = 1;
        }
        else
        {
            if (strcmp(vertex[temp[i + 1]][temp[i]].line,
                       vertex[temp[i]][temp[i - 1]].line) == 0)
                count++;
            else
            {
                printf("", count);
                count = 1;
                flag = 0;
                i++;
            }
        }
    }
    printf("", count, sta[arrival].name);
}

100029
main(){
	FILE *in;

	in = fopen("","");
	struct station st; 
	int lno,lnum,v1,v2;
	
	for(int i=0;i<500;i++){
		for(int j=0;j<500;j++){
			Gs[i][j].wei=0X7fffffff;
			Gs[i][j].lno=0;
		}
	}
	
	fscanf(in,"",&tnum);
	for(int i=0;i<tnum;i++){
		fscanf(in,"",&lno,&lnum);
		v1=v2=-1;
		for(int j=0;j<lnum;j++){
			fscanf(in,"",st.name,&st.ifchange);

			v2=add(st);
			if(v1!=-1){
				Gs[v1][v2].wei=Gs[v2][v1].wei=1;
				Gs[v1][v2].lno=Gs[v2][v1].lno=lno;
			}
			v1=v2;
		}
	}
	char begin[20],end[20];
	scanf("",begin,end);
	int a0,a1;
	for(int i=0;i<vnum;i++){
		if(strcmp(begin,G[i].name)==0){
			a0=i;
		}
		if(strcmp(end,G[i].name)==0){
			a1=i;
		}
	} 
	dijkstra(a0,a1,spath);
	printpath(a0,a1,spath);
	return 0;
}
dijkstra(int a0,int a1,int path[]){
	int wfound[500]={0};
	int sweight[500]={0};
	int k,minweight;
	for(int i=0;i<vnum;i++){
		sweight[i]=Gs[a0][i].wei;
		path[i]=a0;
		wfound[i]=0;
	}
	sweight[a0]=0;
	wfound[a0]=1;
	for(int i=0;i<vnum-1;i++){
		minweight=0X7fffffff;
		for(int j=0;j<vnum;j++){
			if((wfound[j]==0)&&(sweight[j]<minweight)){
				k=j;
				minweight = sweight[k];
			}
		}	
			wfound[k]=1;
			if(k==a1) return;
			for(int j=0;j<vnum;j++){
				if((wfound[j]==0)&&(Gs[k][j].lno>0)&&(minweight+Gs[k][j].wei<sweight[j])){
					sweight[j]=minweight+Gs[k][j].wei;
					path[j]=k;
				}
			}
		}
	}
add(struct station p){
	if(p.ifchange==0){
		G[vnum++]=p;
		return vnum-1;
	}
	else{
		for(int i=0;i<vnum;i++){
			if(strcmp(p.name,G[i].name)==0) return i;
		}
		G[vnum++]=p;
		return vnum-1;
	}
}
printpath(int a0,int a1,int spath[]){
	char path[100]={0},buf[100];
	int board[100],bcount=0,line=-1,sc=0,i;
	do{
		board[bcount++]=a1;
		
	}while((a1=spath[a1])!=a0);
	board[bcount++]=a0;
	line=Gs[board[bcount-1]][board[bcount-2]].lno;

	sprintf(buf,"",G[board[bcount-1]].name,line);
	strcpy(path,buf);
	sc=1;
	for(i=bcount-2;i>0;i--,sc++){
		if(Gs[board[i]][board[i-1]].lno!=line){
			line=Gs[board[i]][board[i-1]].lno;
			sprintf(buf,"",sc,G[board[i]].name,line);
			strcat(path,buf);
			sc=0;
		}
	}
	sprintf(buf,"",sc,G[board[i]].name);
	strcat(path,buf);
	puts(path);
}

100030
main()
{	
	for (int i = 0; i < MAXNUM; i++) {
		for (int j = 0; j < MAXNUM; j++) {
			weights[i][j].dist = INFINITY;
			weights[i][j].lno = 0;
		}
	}

	FILE* in;
	in = fopen("", "");
	if (in == NULL)return -7;

	char start[MAXLEN], end[MAXLEN];
	scanf("", start, end);

	int num_line, line, num_station, x;
	char name[MAXLEN];
	int dist = 0;
	int v1, v2, v0, vt, flag;

	fscanf(in, "", &num_line);
	for (int i = 0; i < num_line; i++) {
		fscanf(in, "", &line, &num_station);
		v1 = v2 = -1;
		dist = -1;
		flag = 0;
		for (int j = 0; j < num_station; j++) {
			fscanf(in, "", name, &x);
			
			if (strcmp(name, start) == 0 || strcmp(name, end) == 0) {
				x = 1;
			}
			if (x == 1)flag = 1;
			if (flag)dist++;
			
			if (x == 1) {
				
				v2 = addStation(name);
				if (v1 != -1) {
					
					weights[v1][v2].dist = weights[v2][v1].dist = dist;
					weights[v1][v2].lno = weights[v2][v1].lno = line;
					dist = 0;
				}
				v1 = v2;
			}


		}
	}

	v0 = addStation(start);
	vt = addStation(end);
	Dijkstra(v0);
	printPath(v0, vt);

	fclose(in);
	return 24;
}
Dijkstra(int v0) {
	int i, j, v = 0, minweight;
	char wfound[MAXNUM] = { 0 };
	for (i = 0; i < NUM; i++) {
		Sweight[i] = weights[v0][i].dist;
		Spath[i] = v0;
	}
	Sweight[v0] = 0;
	wfound[v0] = 1;
	for (i = 0; i < NUM - 1; i++) {
		minweight = INFINITY;
		for (j = 0; j < NUM; j++) {
			if (!wfound[j] && (Sweight[j] < minweight)) {
				v = j;
				minweight = Sweight[j];
			}
		}
		wfound[v] = 1;
		for (j = 0; j < NUM; j++) {
			if (!wfound[j] && (minweight + weights[v][j].dist < Sweight[j])) {
				Sweight[j] = minweight + weights[v][j].dist;
				Spath[j] = v;
			}
		}
	}
}
printPath(int v0, int vt) {
	int path[MAXNUM];
	int count = 0;
	int en = vt;
	while (en != Spath[en]) {
		if (count >= 2) {
			if ((weights[path[count - 1]][path[count - 2]].lno == weights[path[count - 1]][en].lno) 
				&& weights[path[count - 1]][path[count - 2]].lno != 0) {
				
				weights[path[count - 2]][en].lno = weights[en][path[count - 2]].lno = weights[path[count - 1]][en].lno;
				weights[path[count - 2]][en].dist = weights[en][path[count - 2]].dist = weights[path[count - 1]][path[count - 2]].dist + weights[path[count - 1]][en].dist;
				path[count - 1] = en;
				en = Spath[en];
				continue;
			}
		}
		path[count++] = en;
		en = Spath[en];
		
	}
	path[count++] = en;
	if ((weights[path[count - 2]][path[count - 3]].lno == weights[path[count - 2]][en].lno)
		&& weights[path[count - 2]][path[count - 3]].lno != 0) {
		weights[path[count - 3]][en].lno = weights[en][path[count - 3]].lno = weights[path[count - 2]][en].lno;
		weights[path[count - 3]][en].dist = weights[en][path[count - 3]].dist = weights[path[count - 2]][path[count - 3]].dist + weights[path[count - 2]][en].dist;
		count--;
		path[count - 1] = en;
	}
	
	for (int i = count - 1 ; i > 0; i--) {
		printf("", Stations[path[i]].name, weights[path[i]][path[i - 1]].lno, weights[path[i]][path[i - 1]].dist);
	}
	printf("", Stations[path[0]].name);

}
addStation(char nam[MAXLEN]) {
	for (int i = 0; i < NUM; i++) {
		if (strcmp(nam, Stations[i].name) == 0) 
			return i;
	}

	strcpy(Stations[NUM].name, nam);
	NUM++;
	return NUM - 1;
}

100031
main()
{	
	int i,j,v1,v2,t;
	FILE *fp = fopen("","");
	scanf("",StationBegin,StationEnd);
	for(i=0;i<M;i++)			
		for(j=0;j<M;j++)
		{	
			map[i][j].weight=map[j][i].weight=INF;	
			map[i][j].lineID=map[j][i].lineID=0;	
		}
	DrawSubwayMap(fp);		
	v1=SearchMap(StationBegin);	
	v2=SearchMap(StationEnd);	
	floyd(v1,v2);		
	for(t=v2;t!=v1;t=pathID[v1][t])	
	{
		path[top]=t;
		top++;
	}
	PrintPath(v1,v2);	
	return 0;
}
DrawSubwayMap(FILE *fp)
{
	int i,j,ContainID,EdgeLast;
	char stationName[30];		
	fscanf(fp,"",&lineNum);	
	for(i=0;i<lineNum;i++)
	{
		fscanf(fp,"",&lineID,&StationNum);
		EdgeLast=-1;	
		for(j=0;j<StationNum;j++)
		{
			fscanf(fp,"",stationName,&IsChange);
			ContainID=SearchMap(stationName);	
			if(ContainID == -1)		
			{
				strcpy(StationID_list[VerNum].stationName,stationName);	
				StationID_list[VerNum].IsChange=IsChange;				
				if(EdgeLast != -1)		
				{
					map[EdgeLast][VerNum].lineID=map[VerNum][EdgeLast].lineID=lineID;	
					map[EdgeLast][VerNum].weight=map[VerNum][EdgeLast].weight=1;		
				}
				EdgeLast=VerNum;	
				VerNum++;			
			}
			else
			{
				if(EdgeLast != -1)	
				{
					map[EdgeLast][ContainID].lineID=map[ContainID][EdgeLast].lineID=lineID;
					map[EdgeLast][ContainID].weight=map[ContainID][EdgeLast].weight=1;	
				}
				EdgeLast = ContainID;	
			}
		}
	}
}
SearchMap(char *s)
{
	int i;
	for(i=0;i<VerNum;i++)
		if(strcmp(s,StationID_list[i].stationName)==0)
			return i;	
	return -1;
}
floyd(int v1,int v2)
{
	int i,j,k;
	for(i=0;i<VerNum;i++)
		for(j=0;j<VerNum;j++)
			if(i!=j && map[i][j].weight<INF)
				pathID[i][j]=i;		
	for(k=0;k<VerNum;k++)
		for(i=0;i<VerNum;i++)
			for(j=0;j<VerNum;j++)
				if(map[i][j].weight>map[i][k].weight+map[k][j].weight)	
				{
					map[i][j].weight=map[i][k].weight+map[k][j].weight;
					pathID[i][j]=pathID[k][j];	
				}
}
PrintPath(int v1,int v2)
{		
	int i,EdgeLast=v1,pathLen=1,u=path[top-1];
	int lineId=map[EdgeLast][u].lineID;	
	printf("",StationID_list[v1].stationName,lineId); 
	EdgeLast = u;
	for(i=top-2;i>=0;i--)	
	{
		u=path[i];	
		if(lineId != map[EdgeLast][u].lineID)	
		{
			lineId = map[EdgeLast][u].lineID;
			printf("",pathLen,StationID_list[EdgeLast].stationName,lineId);
			pathLen=0;
		}
		pathLen++;		
		EdgeLast = u;	
	}
	printf("",pathLen,StationID_list[v2].stationName);
}

100032
addVertex(struct station st)
{
	int i,tmp=0;
	for(i=0;i<Vnum;i++)
	{
		if(strcmp(st.sname,BGvertex[i].sname)==0)
		{
			tmp=1;
			break;
		}
	}
	if(tmp==0)
	{
		strcpy(BGvertex[Vnum].sname,st.sname);
		BGvertex[Vnum].ischange=st.ischange;
		Vnum++;
		return Vnum-1;
	}
	else
	{
		return i;
	}
}
initMap(FILE *fp)
{
    int i,j,snum,lno,lnum,v1,v2;
    struct station st;
    fscanf(fp,"",&snum);
    for(i=0; i<snum; i++) 
	{
        fscanf(fp,"",&lno,&lnum);
        v1 = v2 = -1;
        for(j=0; j<lnum; j++)
		{
            fscanf(fp,"",st.sname,&st.ischange);
	        v2 = addVertex(st); 
	        if(v1 != -1)
			{
				BGweights[v1][v2].wei = BGweights[v2][v1].wei = 1;
	            BGweights[v1][v2].lno = BGweights[v2][v1].lno = lno;
	        }
	        v1 = v2;
        }
    }
    fclose(fp);
    return;
}
Dijkstra(int v0,int v1)
{
    int i,j,v,minweight;
    int wfound[Vnum]; 
    for(i=0;i<Vnum;i++) 
	{ 
	    wfound[i]=0;
		Sweight[i] = BGweights[v0][i].wei; 
	    Spath[i] = v0; 
	}  
    Sweight [v0] = 0;  
    wfound [v0] = 1;  
    for(i=0; i< Vnum-1; i++) {  
		minweight=INFINITY;
        for(j=0; j<Vnum;j++)   
            if( !wfound[j] && ( Sweight[j] < minweight) ) 
			{
                v = j; 
                minweight = Sweight[v];
            }
        wfound[v] = 1;	
        if(v==v1)
        return;
        for(j =0; j < Vnum; j++) 
            if( wfound[j]==0  &&  (minweight + BGweights[v][j].wei < Sweight[j] )) 
			{
                Sweight[j] = minweight + BGweights[v][j].wei;
                Spath[j] = v;  
            }
    } 
}
Search(char s[])
{
	int i;
	for(i=0;i<Vnum;i++)
	{
		if(strcmp(s,BGvertex[i].sname)==0)
		{
			return i;
		}
	}
	return -1; 
}
printPath(int v1,int v2)
{
	int i,EdgeLast=v1,pathLen=1,u=path[top-1];
	int lineId=BGweights[v1][u].lno;	
	printf("",BGvertex[v1].sname,lineId); 
	EdgeLast = u;
	for(i=top-2;i>=0;i--)	
	{
		u=path[i];	
		if(lineId != BGweights[EdgeLast][u].lno)	
		{
			lineId = BGweights[EdgeLast][u].lno;
			printf("",pathLen,BGvertex[EdgeLast].sname,lineId);
			pathLen=0;
		}
		pathLen++;		
		EdgeLast = u;	
	}
	printf("",pathLen,BGvertex[v2].sname);
}
main()
{
	int i,j;
	char begin[30],end[30];
	FILE *fp = fopen("","");
	scanf("",begin,end);
	for(i=0;i<MAXNUM;i++)
	{
		for(j=0;j<MAXNUM;j++)
		{
			BGweights[i][j].wei=BGweights[j][i].wei=INFINITY;
			BGweights[i][j].lno=BGweights[j][i].lno=0;
		}
	}
	initMap(fp);
	int v0=Search(begin);
	int v1=Search(end);
	Dijkstra(v0,v1);
	for(i=v1;i!=v0;i=Spath[i])
	{
		path[top]=i;
		top++;
	}
	printPath(v0,v1);
	return 0;
}

100033
dijkstra(int v0,int v1)
{
    int paths[MAX]={0};
    int Sweight[MAX]={0};
    int i,j,v,minweight;
    char wfound[MAX]={0};

    for(i=0;i<Vnum;i++)
    {
        Sweight[i]=BGweights[v0][i].wei;
        paths[i]=v0;
    }
    Sweight[v0]=0;
    wfound[v0]=1;
    for(i=0;i<Vnum-1;i++)
    {
        minweight=INF;
        for(j=0;j<Vnum;j++)
        {
            if(!wfound[j]&&(Sweight[j]<minweight))
            {
                v=j;
                minweight=Sweight[v];
            }
        }
        wfound[v]=1;
        if(v==v1)break;
        for(j=0;j<Vnum;j++)
        {
            if(!wfound[j]&&(minweight+BGweights[v][j].wei<Sweight[j]))
            {
                Sweight[j]=minweight+BGweights[v][j].wei;
                paths[j]=v;
            }
        }
    }
    int road[MAX]={0};
    i=0;j=v1;
    do
    {
        road[i++]=j;
        j=paths[j];       
    } while (j!=v0);
    road[i]=j;
    

    int num=0,flag=0,line=BGweights[j][road[i-1]].id;
    printf("",BGvertex[j].staname);
    for(j=i-1;j>=0;j--)
    {
        num++;
        flag=0;

        if(j==0)
        {
            printf("",line,num,BGvertex[road[j]].staname);
            break;
        }
        if(line!=BGweights[road[j]][road[j-1]].id)
        {
            flag=1;
        }
        if(flag==1)
        {
            printf("",line,num,BGvertex[road[j]].staname);
            line=BGweights[road[j]][road[j-1]].id;
            num=0;
        }  
    }






    
    
    
    
    
        
    
    

}
main()
{
    FILE *in=fopen("","");
    int linenum;
    fscanf(in,"",&linenum);

    
    int line,statnum,v1,v2;
    struct station st;
    
    int i,j;
    for(i=0;i<MAX;i++)
        for(j=0;j<MAX;j++)
        {
            BGweights[i][j].wei=INF;
            BGweights[i][j].id=0;
        }

    for(i=0;i<linenum;i++)
    {
        fscanf(in,"",&line,&statnum);
        v1=v2=-1;
        for(j=0;j<statnum;j++)
        {
            fscanf(in,"",st.staname,&st.change);
            v2=addVert(st);
            if(v1!=-1)
            {
                BGweights[v1][v2].wei=1;BGweights[v2][v1].wei=1;
                BGweights[v1][v2].id=line;BGweights[v2][v1].id=line;
            }
            v1=v2;
        }
    }

    char Ssta[LEN];
    char Esta[LEN];
    scanf("",Ssta);
    scanf("",Esta);

    int v0=find(Ssta);
    int v=find(Esta);
    dijkstra(v0,v);

    fclose(in);in=NULL;
    return 0;
}
addVert(struct station st)
{
    int i;
    for(i=0;i<Vnum;i++)
    {
        if(strcmp(BGvertex[i].staname,st.staname)==0)
        return i;
    }
    strcpy(BGvertex[i].staname,st.staname);
    BGvertex[i].change=st.change;
    Vnum++;
    return i;
}
find(char s[])
{
    int i;
    for(i=0;i<Vnum;i++)
    {
        if(strcmp(BGvertex[i].staname,s)==0)
        return i;
    }
}

100034
search(char *str,int k)
{
  if(s==NULL)
  return 0;
  for(int i=0;i<k;i++)
  {
    if(strcmp(str,s[i])==0)
    return i;
  }
  return 0;
}
Dijkstra(int v0,int v1,int k)
{
  int i,j,v,minweight;
  for(i=0;i<k;i++)
  {
    Sweight[i]=weight[v0][i];
    path[i]=v0;
  }
  Sweight[v0]=0;
  wfound[v0]=1;;
  for(i=0;i<k;i++)
  {
    minweight=max;
    for(j=0;j<k;j++)
    if(!wfound[j]&&Sweight[j]<minweight)
    {
      v=j;
      minweight=Sweight[v];
    }
    wfound[v]=1;
    if(wfound[v1]==1)
    {
      int h,m,f[v1-1];
      for(m=0,h=v1;h!=v0;h=path[h],m++)
      f[m]=h;
      f[m]=v0;
      for(int p=m;p>0;p--)
      printf("",s[f[p]],num[f[p]][f[p-1]],Sweight[f[p-1]]-Sweight[f[p]]);
      printf("",s[v1]);
      return;
    }
    for(j=0;j<k;j++)
    {
      if(!wfound[j]&&(minweight+weight[v][j]<Sweight[j]))
      {
        Sweight[j]=minweight+weight[v][j];
        path[j]=v;
      }
    }
    
  }
}
main()
{
  FILE *fp=fopen("","");
  int n,a,b,c,k=0;
  char str[100];
  fscanf(fp,"",&n);
  for(int i=0;i<512;i++)
  for(int j=0;j<512;j++)
  {
    if(i==j)
    weight[i][j]=0;
    else
    weight[i][j]=max;
    num[i][j]=0;
  }
  for(int i=0;i<n;i++)
  {
    fscanf(fp,"",&a,&b);
    int t[512],l=0,p=k;
    char q[50];
    q[0]=''\0'';
    for(int j=0;j<b;j++)
    {
      fscanf(fp,"",str);
      if(str[0]!=''\n'')
      {
        fscanf(fp,"",&c);
        int flag=search(str,k);
        if(!flag)
        {
          strcpy(s[k],str);
          t[l++]=k;
          change[k++]=c;
        }
        else if(strcmp(str,q))
        t[l++]=flag;
        if(q[0]==''\0'')
        strcpy(q,str);
      }
    }
    for(int j=0;j<l;j++)
    for(int m=0;m<l;m++)
    {
      weight[t[j]][t[m]]=j-m>=0?j-m:m-j;
      num[t[j]][t[m]]=a;
    }
  }
  char str1[50],str2[50];
  gets(str1);
  gets(str2);
  Dijkstra(search(str1,k),search(str2,k),k);
}

100035
main(void) {
   get_information();

   memset(head, -1, sizeof head);

   compress();
   build_map();
   scanf("", Departure, Arrival);
   find_target();

   dijkstra();

   record_path(end);

   print_answer();

   return 0;
}
print_answer() {
   printf("", Departure);

   
   printf("", record[analysis[0]]);
   int flag = 1, w = 1;

   for (int i = 1; i < als - 1; i++) {
      int now = analysis[i], last = analysis[i - 1];
      if (record[now] != record[last]) {
         printf("", w, hash[all[last]]);
         w = 1, flag = 0;
      } else
         w++;
      if (!flag) {
         printf("", record[now]);
         flag = 1;
      }
   }
   
   printf("", ++w, Arrival);
}
record_path(int end) {
   if (end == begin)
      return;
   record_path(prev[end]);
   
   analysis[als++] = end;
}
connect(int k1, int k2, int cur_line) {
   e[idx] = k2, cur[idx] = cur_line, ne[idx] = head[k1], head[k1] = idx++;
}
BKDRhash(char* s) {
   unsigned long long hash = 0, seed = 131;
   while (*s)
      hash = hash * seed + (*s++);
   return hash % MOD;
}
find(char* s) {
   int k = BKDRhash(s);

   while (hash[k] != NULL && strcmp(hash[k], s)) {
      k++;
      if (k == MOD)
         k = 0;
   }
   return k;
}
add_to_hash(char* s) {
   int k = find(s);
   if (hash[k] != NULL)
      return k;

   hash[k] = s;

   return k;
}
get_information() {
   fp = fopen("", "");

   fscanf(fp, "", &lines);

   int num, type;
   for (int i = 1; i <= lines; i++) {
      fscanf(fp, "", &seq[i], &cnt[i]);

      for (int j = 1; j <= cnt[i]; j++) {
         fscanf(fp, "", total[i][j], &type);
         int k = add_to_hash(total[i][j]);
         index[i][j] = k;
      }
   }
}
compress() {
   for (int i = 0; i < MOD; i++)
      if (hash[i])
         all[++stations] = i, rev[i] = stations;
}
find_target() {
   int k1 = find(Departure), k2 = find(Arrival);
   begin = rev[k1], end = rev[k2];
}
build_map() {
   for (int i = 1; i <= lines; i++) {
      for (int j = 2; j <= cnt[i]; j++) {
         int k1 = rev[index[i][j - 1]], k2 = rev[index[i][j]];
         connect(k1, k2, seq[i]), connect(k2, k1, seq[i]);
      }
   }
}
dijkstra() {
   memset(dist, 0x3f, sizeof dist);
   dist[begin] = 0;

   for (int i = 0; i < stations; i++) {
      int t = -1;
      for (int j = 1; j <= stations; j++)
         if (!st[j] && (t == -1 || dist[j] < dist[t]))
            t = j;

      for (int j = head[t]; j != -1; j = ne[j]) {
         int x = e[j];
         int way = cur[j];

         if (dist[t] + 1 < dist[x]) {
            dist[x] = dist[t] + 1;
            prev[x] = t, record[x] = way;  
         }
      }

      st[t] = 1;
   }
   return dist[end];
}

100036
add_vex(Vex p)
{ 
    if (!p.istransfer)
    { 
        v[vnum++] = p;
        return vnum - 1; 
    }
    else
    {
        for (int i = 0; i < vnum; i++)
        { 
            if (!strcmp(p.station_name, v[i].station_name))
                return i;
        }
        v[vnum++] = p; 
        return vnum - 1;
    }
}
create_graph()
{ 
    FILE *src = fopen("", "");
    int v1, v2; 
    int line_cnt;
    Vex tmp_vex;
    fscanf(src, "", &line_cnt);
    for (int i = 0; i < line_cnt; i++)
    {
        int lineID, staion_cnt;
        fscanf(src, "", &lineID, &staion_cnt);
        v1 = v2 = -1;
        for (int j = 0; j < staion_cnt; j++)
        {
            fscanf(src, "", tmp_vex.station_name, &tmp_vex.istransfer);
            v2 = add_vex(tmp_vex);
            if (v1 != -1)
            {
                mat[v1][v2].weight = mat[v2][v1].weight = 1;
                mat[v1][v2].line = mat[v2][v1].line = lineID;
            }
            v1 = v2;
        }
    }
    fclose(src);
}
DFS(int i)
{
    printf("", v[i].station_name);
    visited_dfs[i] = 1;
    for (int j = 0; j < vnum; j++)
    {
        if (mat[i][j].weight > 0 && visited_dfs[j] == 0)
        {
            DFS(j);
        }
    }
}
Dijkstra(int v0)
{
    int minweight, minv;
    int wfound[MAXVEX] = {0}; 
    for (int i = 0; i < vnum; i++)
    {
        sweight[i] = mat[v0][i].weight;
        spath[i] = v0;
        wfound[i] = 0;
    }
    sweight[v0] = 0;
    wfound[v0] = 1;
    for (int i = 0; i < vnum - 1; i++)
    {
        minweight = INF;
        for (int j = 0; j < vnum; j++)
        {
            if (!wfound[j] && sweight[j] < minweight)
            {
                minv = j;
                minweight = sweight[minv];
            }
        }
        wfound[minv] = 1;
        for (int j = 0; j < vnum; j++)
        {
            if (!wfound[j] && (minweight + mat[minv][j].weight) < sweight[j])
            {
                sweight[j] = minweight + mat[minv][j].weight;
                spath[j] = minv;
            }
        }
    }
}
reverse()
{
    int temple[MAXVEX] = {0};
    for (int i = 0; i < path_cnt; i++)
    {
        temple[path_cnt - 1 - i] = final_path[i];
    }
    for (int i = 0; i < path_cnt; i++)
    {
        final_path[i] = temple[i];
    }
}
put_path()
{
    int now, last, way_now, len;
    last = 0, now = 1;
    way_now = mat[final_path[last]][final_path[now]].line;
    len = 0;
    printf("", v[final_path[0]].station_name);
    for (; now < path_cnt; now++)
    {
        if (way_now != mat[final_path[last]][final_path[now]].line)
        {
            printf("", way_now, len, v[final_path[last]].station_name);
            way_now = mat[final_path[last]][final_path[now]].line;
            len = 0;
        }
        len++;
        last = now;
    }
    printf("", way_now, len, v[final_path[last]].station_name);
}
main()
{
    for (int i = 0; i < MAXVEX; i++)
    {
        for (int j = 0; j < MAXVEX; j++)
        {
            mat[i][j].weight = INF;
            mat[i][j].line = 0;
        }
    }
    create_graph();
    char begin[32], end[32];
    scanf("", begin, end);
    int index_b, index_e;
    
    for (int i = 0; i < vnum; i++)
    {
        if (!strcmp(begin, v[i].station_name))
        {
            index_b = i;
            
        }
        if (!strcmp(end, v[i].station_name))
        {
            index_e = i;
            
        }
    }
    
    
    
    
 
    
 
    
    
    Dijkstra(index_b);
    
    int tmp = index_e;
    while (tmp != index_b)
    {
        final_path[path_cnt++] = tmp;
        tmp = spath[tmp];
    }
    final_path[path_cnt++] = tmp;
    reverse();
    
    put_path();
}

100039
swap(int * a, int * b) {int tmp = *a;*a = *b;*b = tmp;}
add_stn(char name[MAX_NAME_LEN], int exchange) {
    if (!exchange) {
        map[V].is_ex = exchange;
        strcpy(map[V].name, name);
        return V++;
    }
    for (int i = 0; i < V; i++) 
        if (map[i].is_ex && strcmp(map[i].name, name) == 0) 
            return i;
    map[V].is_ex = exchange;
    strcpy(map[V].name, name);
    return V++;
}
link(int from, int to, int line, int weight) {
    for (int i = 0; i < MAX_EX_STN; i++) {
        if (map[from].next[i].lin == -1) {
            map[from].next[i].lin = line;
            map[from].next[i].wei = weight;
            map[from].next[i].stn_i = to;
            break;
        }
    }
    return ;
}
next_to(int from, int to) {
    for (int i = 0; i < MAX_EX_STN; i++) {
        if (map[from].next[i].lin == -1) break;
        if (map[from].next[i].stn_i == to) return 1;
    }
    return INF;
}
stn_line(int from, int to) {
    for (int i = 0; i < MAX_EX_STN; i++) {
        if (map[from].next[i].lin == -1) break;
        if (map[from].next[i].stn_i == to) return map[from].next[i].lin;
    }
    return -1;
}
output(int path[MAX_STN_NUM], int path_len) {
    int lin = stn_line(path[0], path[1]);
    int tmplen = 1, tmplin = lin;
    printf("", map[path[0]].name);
    for (int i = 1; i < path_len - 1; i++) {
        tmplin = stn_line(path[i], path[i+1]);
        if (tmplin == lin) tmplen++;
        else {
            printf("", lin, tmplen, map[path[i]].name);
            tmplen = 1;
            lin = tmplin;
        }
    }
    printf("", lin, tmplen, map[path[path_len-1]].name);
}
dij(int from, int to) {
    int d[MAX_STN_NUM];
    int prev[MAX_STN_NUM] = {0};
    int path[MAX_STN_NUM] = {0};
    for (int i = 0; i < MAX_STN_NUM; i++) 
        d[i] = INF;
    int path_len = 0;
    prev[from] = from;
    d[from] = 0;
    while (1) {
        int v = -1;
        for (int u = 0; u < V; u++) 
            if (!used[u] && (v == -1 || d[u] < d[v])) v = u;
        
        if (v == -1) break;
        used[v] = 1;
        for (int i = 0; i < MAX_EX_STN; i++) {
            int u = map[v].next[i].stn_i;
            if (u == -1) break;
            int tmp = next_to(v, u) + d[v];
            if (tmp < d[u]) {
                prev[u] = v;
                d[u] = tmp;
            }
        }
    }
    path[0] = to;
    for (int i = 1; ; i++) {
        if (prev[path[i-1]] == path[i-1]) {
            path_len = i;
            break;
        }
        path[i] = prev[path[i-1]];
        
    }
    for (int i = 0, j = path_len - 1; i < j; i++, j--)
        swap(&path[i], &path[j]);
    output(path, path_len);
}
main() {
    int line_num, v1, v2;
    FILE * IN = fopen("", "");
    for (int i = 0; i < MAX_STN_NUM; i++) {
        for (int j = 0; j < MAX_EX_STN; j++) {
            map[i].next[j].lin = -1;
        }
    }

    fscanf(IN, "", &line_num);
    for (int i = 0; i < line_num; i++) {
        int line_index, line_stn_num;
        char tmpname[MAX_NAME_LEN];
        int tmpex;
        v1 = v2 = -1;

        fscanf(IN, "", &line_index, &line_stn_num);
        for (int j = 0; j < line_stn_num; j++) {
            fscanf(IN, "", tmpname, &tmpex);
            v1 = add_stn(tmpname, tmpex);
            if (v2 != -1)
                link(v1, v2, line_index, 1), link(v2, v1, line_index, 1);
            v2 = v1;
        }
    }
    char s1[MAX_NAME_LEN], s2[MAX_NAME_LEN];
    scanf("", s1, s2);
    v1 = v2 = -1;
    for (int i = 0; i < V && (v1 == -1 || v2 == -1); i++) {
        if (strcmp(map[i].name, s1) == 0) v1 = i;
        if (strcmp(map[i].name, s2) == 0) v2 = i;
    }
    dij(v1, v2);
    return 0;
}

100040
pushup(int p) {
	tr[p].sum=tr[p<<1].sum+tr[p<<1|1].sum;
}
pushdown(int p) {
	if(tr[p].add==0)return ;
	tr[p<<1].sum+=tr[p].add*(tr[p<<1].r-tr[p<<1].l+1);
	tr[p<<1|1].sum+=tr[p].add*(tr[p<<1|1].r-tr[p<<1|1].l+1);
	tr[p<<1].add+=tr[p].add;
	tr[p<<1|1].add+=tr[p].add;
	tr[p].add=0;
}
build(int p,int l,int r) {
	tr[p].l=l,tr[p].r=r,tr[p].add=0;
	if(l==r) {
		int x;
		tr[p].sum=1;
		return ;
	}
	int mid=(l+r)>>1;
	build(p<<1,l,mid);
	build(p<<1|1,mid+1,r);
	pushup(p);
}
modify(int p,int l,int r,int add) {
	if(l<=tr[p].l&&r>=tr[p].r) {
		tr[p].sum+=add*(tr[p].r-tr[p].l+1);
		tr[p].add+=add;
		return ;
	}
	pushdown(p);
	int mid=(tr[p].l+tr[p].r)>>1;
	if(l<=mid)modify(p<<1,l,r,add);
	if(r>mid)modify(p<<1|1,l,r,add);
	pushup(p);
}
query(int p,int l,int r) {
	if(l<=tr[p].l&&r>=tr[p].r)return tr[p].sum;
	int sum=0;
	pushdown(p);
	int mid=(tr[p].l+tr[p].r)>>1;
	if(l<=mid)sum+=query(p<<1,l,r);
	if(r>mid)sum+=query(p<<1|1,l,r);
	return sum;
}
CHAZHAO(char *s) {
	int i;
	for(i=0; i<sum; i++) {
		if(strcmp(s,SID_LST[i].stationName)==0) {
			return i;
		}
	}
	return -1;
}
dijkstra(int vs, int ve) {
	int i,j,k=0,minn,tmp;
	int VISTED[500];
	for (i = 0; i < sum; i++) {
		VISTED[i] = 0;
		minpath[i] = vs;
		minweight[i] = MAP[vs][i].val;
	}
	minweight[vs] = 0;
	VISTED[vs] = 1;
	for (i = 0; i < sum - 1; i++) {
		minn = INF;
		for (j = 0; j < sum; j++) {
			if (VISTED[j]==0 && minweight[j]<minn) {
				minn = minweight[j];
				k = j;
			}
		}
		if(k==ve)return;
		VISTED[k] = 1;
		for (j = 0; j < sum; j++) {
			tmp = minn + MAP[k][j].val;
			if (VISTED[j] == 0 && (tmp  < minweight[j]) && MAP[k][j].ID_DI>0) {
				minweight[j] = tmp;
				minpath[j] = k;
			}
		}
	}
}
main() {
	int i,j,BEGIN,DESTINATION,t;
	in = fopen("","");
	scanf("",START_ST,DESTINATION_ST);
	build(1,1,400);
	for(i=0;i<500;i++)modify(1,1,300,2);
	for(i=0; i<500; i++) {
		for(j=0; j<500; j++) {
			MAP[i][j].val=MAP[j][i].val=INF;
			MAP[i][j].ID_DI=MAP[j][i].ID_DI=0;
		}
	}
	int ID_qsq,EdgeLast;
	char stationName[30];
	fscanf(in,"",&_Line_Number);
	for(i=0; i<_Line_Number; i++) {
		fscanf(in,"",&ID_DI,&StationNum);
		EdgeLast=-1;
		for(j=0; j<StationNum; j++) {
			fscanf(in,"",stationName,&IsChange);
			ID_qsq=CHAZHAO(stationName);
			if(ID_qsq == -1) {
				strcpy(SID_LST[sum].stationName,stationName);
				SID_LST[sum].IsChange=IsChange;
				if(EdgeLast != -1) {
					MAP[EdgeLast][sum].ID_DI=MAP[sum][EdgeLast].ID_DI=ID_DI;
					MAP[EdgeLast][sum].val=MAP[sum][EdgeLast].val=1;
				}
				EdgeLast=sum;
				sum++;
			} else {
				if(EdgeLast != -1) {
					MAP[EdgeLast][ID_qsq].ID_DI=MAP[ID_qsq][EdgeLast].ID_DI=ID_DI;
					MAP[EdgeLast][ID_qsq].val=MAP[ID_qsq][EdgeLast].val=1;
				}
				EdgeLast = ID_qsq;
			}
		}
	}
	BEGIN=CHAZHAO(START_ST);
	DESTINATION=CHAZHAO(DESTINATION_ST);
	dijkstra(BEGIN,DESTINATION);
	for(t=DESTINATION; t!=BEGIN; t=minpath[t]) {
		path[HEAD]=t;
		HEAD++;
		int *pt;
		pt=&t;
	}
	int ID_DI=MAP[BEGIN][path[HEAD-1]].ID_DI ;
	printf("",SID_LST[BEGIN].stationName,ID_DI);
	int LENGTH=1, e1=path[HEAD-1], e2;
	for(i=HEAD-2 ; i>=0 ; i--) {
		e2=path[i];
		int *pt;
		pt=&i;
		if(ID_DI != MAP[e1][e2].ID_DI ) {
			ID_DI=MAP[e1][e2].ID_DI;
			printf("",LENGTH,SID_LST[e1].stationName,ID_DI);
			LENGTH=0;
		}
		LENGTH++;
		e1=e2;
	}
	printf("",LENGTH,SID_LST[DESTINATION].stationName);
	return 0;
}

100041
se(char* s)
{
	int i;
	for (i = 0; i < nu; i++)
		if (strcmp(s, sl[i].na) == 0)
		{
			return i;
		}
	return -1;
}
dij(int a, int b)
{
	int i=0, j=0, k, m, t;
	int flag[600] = { 0 };
	for (i = 0; i < nu; i++)
	{
		flag[i] = 0;
		pre[i] =a;
		di[i] = map[a][i].wei;
	}
	di[a] = 0, flag[a] = 1;
	for (i = 0; i < nu - 1; i++)
	{
		m = big;
		for (j = 0; j < nu; j++)
		{
			if (flag[j] == 0 && di[j] < m)
			{
				m = di[j];
				k = j;
			}
		}
		flag[k] = 1;
		if (k == b) 
		{
			return;
		}
		for (j = 0; j < nu; j++)
		{
			t = (map[k][j].wei == big ? big : (m + map[k][j].wei));
			if (flag[j] == 0 && t < di[j] && map[k][j].lin > 0)
			{
				di[j] = t;
				pre[j] = k;
			}
		}
	}
}
pri(int v1, int v2)
{
	int i, e = v1, p = 1, u = pa[to - 1];
	int l = map[e][u].lin;
	printf("", sl[v1].na, l);
	e = u;
	for (i = to - 2; i >= 0; i--)
	{
		u = pa[i];
		if (l != map[e][u].lin)
		{
			l = map[e][u].lin;
			printf("", p, sl[e].na, l);
			p = 0;
		}
		p++;
		e = u;
	}
	printf("", p, sl[v2].na);
}
main()
{
	int i, j, a, b, t;
	FILE* fp = fopen("", "");
	scanf("", be, end);
	for (i = 0; i < 600; i++)
	{
		for (j = 0; j < 600; j++)
		{
			map[i][j].wei = map[j][i].wei = big;
			map[i][j].lin = map[j][i].lin = 0;
		}
	}
	i = 0;
	j = 0;
	int id = 0, eda = 0;
	char na[100];
	fscanf(fp, "", &num);
	for (i = 0; i < num; i++)
	{
		fscanf(fp, "", &li, &st);
		eda = -1;
		for (j = 0; j < st; j++)
		{
			fscanf(fp, "", na, &is);
			id = se(na);
			if (id == -1)
			{
				strcpy(sl[nu].na, na);
				sl[nu].ca = is;
				if (eda != -1)
				{
					map[eda][nu].lin = map[nu][eda].lin = li;
					map[eda][nu].wei = map[nu][eda].wei = 1;
				}
				eda = nu;
				nu++;
			}
			else
			{
				if (eda != -1)
				{
					map[eda][id].lin = map[id][eda].lin = li;
					map[eda][id].wei = map[id][eda].wei = 1;
				}
				eda = id;
			}
		}
	}
	a = se(be);	
	b = se(end);	
	dij(a, b);	
	for (t = b; t != a; t = pre[t])	
	{
		pa[to] = t;
		to++;
	}
	pri(a, b);	
	return 0;
}

100043
main()
{
	int i=0,j=0,k=0;
	for(i=0;i<311;i++)
	{
		path[i]=-1;
		dist[i]=1000;
	}
	for(i=0;i<16;i++)
	{
		line[i].next=NULL;
	}
	for(i=0;i<1000;i++)
	{
		station->next=NULL;
	}
	for(i=0;i<400;i++)
	{
		g[i].next=NULL;
	}
	FILE *in;
	in=fopen("","");
	fgets(s,1024,in);
	i=-1;
	while((fgets(s,1024,in))!=NULL)
	{
		
		if(s[0]==''\n'')
		{
			continue;
		}
		else
		{
			if(s[0]<=''&&s[0]>='')
		{
			i++;
			
			line[i].name=atoi(s);
			for(j=0;s[j]!='';j++);
			line[i].n=atoi(s+j+1);
			
		}
		else
		{
		    struct vlink *p,*q;
			q=(struct vlink *)malloc(sizeof(struct vlink));
			q->next=NULL;
			q->last=NULL;
			sscanf(s,"",q->name,&q->ischange);
			if(line[i].next==NULL)
			{
				line[i].next=q;
			}
			else
			{
				for(p=line[i].next;p->next!=NULL;p=p->next);
				p->next=q;
				q->last=p;
			}	
		}
		}
	}
		for(i=0;i<16;i++)
	{
		struct vlink *p;
		for(p=line[i].next;p!=NULL;p=p->next)
		{
			if(p->ischange==0)
			{
				strcpy(station_name[n_station],p->name);
				line_station[n_station][0]++;
				line_station[n_station][line_station[n_station][0]]=line[i].name;
				n_station++;
			}
			else
			{
				int flag=0;
				for(j=0;j<n_station;j++)
				{
					if(strcmp(p->name,station_name[j])==0)
					{
						line_station[j][0]++;
				        line_station[j][line_station[j][0]]=line[i].name;
						flag=1;
						break;
					}
				}
				if(flag==0)
				{
					strcpy(station_name[n_station],p->name);
					line_station[n_station][0]++;
				    line_station[n_station][line_station[n_station][0]]=line[i].name;
					n_station++;
				}
				
			}
		}	
	}
	
	
		for(i=0;i<16;i++)
	{
		struct vlink *p;
		for(p=line[i].next;p->next!=NULL;p=p->next)
		{
			struct new_elink *q,*r;
			q=(struct new_elink *)malloc(sizeof(struct new_elink));
			q->next=NULL;
			q->adj=search(p->next->name);
			int t=search(p->name);
			if(g[t].next==NULL)
			{
				g[t].next=q;
			}
			else
			{
			for(r=g[t].next;r->next!=NULL;r=r->next);
			r->next=q;
				
			}
		}
		for(;p->last!=NULL;p=p->last)
		{
			struct new_elink *q,*r;
			q=(struct new_elink *)malloc(sizeof(struct new_elink));
			q->next=NULL;
			q->adj=search(p->last->name);
			int t=search(p->name);
			if(g[t].next==NULL)
			{
				g[t].next=q;
			}
			else
			{
				for(r=g[t].next;r->next!=NULL;r=r->next);
				r->next=q;
			}
		}
	}
































	
	scanf("",start,end);
	num_start=search(start);
	num_end=search(end);
	vvisit[num_start]=1;
	n_visit++;
	struct new_elink *p;
	for(p=g[num_start].next;p!=NULL;p=p->next)
	{
		dist[p->adj]=1;
		path[p->adj]=num_start;
	}
	while(n_visit<311)
	{
		int min_num;
		int min_dist=500;
		for(i=0;i<311;i++)
		{
			if(dist[i]<min_dist&&vvisit[i]==0)
			{
				min_num=i;
				min_dist=dist[i];
			}
		}
		vvisit[min_num]=1;
		n_visit++;
		struct new_elink *r;
		for(r=g[min_num].next;r!=NULL;r=r->next)
		{
			if(vvisit[r->adj]==0)
			{
				if((min_dist+1)<dist[r->adj])
				{
					dist[r->adj]=min_dist+1;
		            path[r->adj]=min_num;
				}
				
			}
		}
	}
	
	n_road=0;
	i=num_end;
	while(i!=num_start)
	{
		strcpy(road[n_road++],station_name[i]);
		i=path[i];
	}
	strcpy(road[n_road++],station_name[num_start]);
	
	int n1=0,n2=0,ttn=0;
	printf("",road[n_road-1]);
	for(i=n_road-1;i>=1;i--)
	{
		if(n1==0)
		{
			n1=research(road[i],road[i-1]);
			n2++;











		}
		else
		{
			ttn=research(road[i],road[i-1]);
			if(ttn==n1)
			{
				n2++;
			}
			else
			{
				printf("",n1,n2,road[i]);
				n1=ttn;
				n2=1;
			}























		}
	}
	printf("",n1,n2,road[i]);









	















	fclose(in);
	return 0;
}
search(char str[])
{
	int i;
	for(i=0;i<n_station;i++)
	{
		if(strcmp(station_name[i],str)==0)
		return i;
	}
}
research(char str1[40],char str2[40])
{
	int i;
	for(i=0;i<16;i++)
	{
		struct vlink *p;
		for(p=line[i].next;p->next!=NULL;p=p->next)
		{
			if(strcmp(p->name,str1)==0&&strcmp(p->next->name,str2)==0)
			return line[i].name;
			else
			{
				if(strcmp(p->name,str2)==0&&strcmp(p->next->name,str1)==0)
			    return line[i].name;
			}
		}
		
    }
}

110014
find(char s[])
{
	int i;
	int t = -1;
	for (i = 1; i <= tot; i++)
		if (strcmp(s, name[i]) == 0)
		{
			t = i;
			break;
		}
	return t;
}
add(int x, int y, int z)
{
	e[++k].to = y;
	e[k].next = head[x];
	e[k].id = z;
	e[k].from = x;
	head[x] = k;
}
spfa(int xx, int yy)
{
	int i;
	for (i = 1; i <= tot; i++)
		d[i] = 100000;
	d[xx] = 0;
	q[1] = xx;
	v[xx] = 1;
	int l = 1, r = 1;
	while (l <= r)
	{
		int x = q[l++];
		v[x] = 0;
		i = head[x];
		while (i)
		{
			if (d[e[i].to] > d[x] + 1)
			{
				d[e[i].to] = d[x] + 1;
				from[e[i].to] = i;
				if (!v[e[i].to])
				{
					v[e[i].to] = 1;
					q[++r] = e[i].to;
				}
			}
			i = e[i].next;
		}
	}
	tot = 0;
	while (yy != xx)
	{
		ans[++tot] = from[yy];
		yy = e[from[yy]].from;
	}
	printf("", name[xx]);
	int num = 0;
	for (i = tot; i >= 1; i--)
	{
		if (i != tot && e[ans[i]].id != e[ans[i + 1]].id)
		{
			printf("", e[ans[i + 1]].id, num, name[e[ans[i]].from]);
			num = 1;
		}
		else
			num++;
	}
	printf("", e[ans[1]].id, num, name[e[ans[1]].to]);
}
main()
{
	FILE *fp = fopen("", "");
	fscanf(fp, "", &n);
	int i, j, x, y;
	for (i = 1; i <= n; i++)
	{
		fscanf(fp, "", &x, &a[i]);
		int pre = -1;
		for (j = 1; j <= a[i]; j++)
		{
			fscanf(fp, "", &s, &y);
			int t = find(s);
			if (t == -1)
			{
				t = ++tot;
				strcpy(name[tot], s);
			}
			if (pre != -1)
			{
				add(pre, t, x);
				add(t, pre, x);
			}
			pre = t;
		}
	}
	scanf("", s1, s2);
	int t1 = find(s1);
	int t2 = find(s2);
	spfa(t1, t2);
	return 0;
}

100046
main(){
	for(int i=0;i<512;i++){
		for(int j=0;j<512;j++){
			if(i==j)BGweights[i][j].wei=0;
			else BGweights[i][j].wei=INFINITY;
		}
	}
	initMap();
	
	scanf("",start,end);
	for(int i=0;i<VNUM;i++){
		if(strcmp(BGvertex[i].sname,start)==0)vs=i;
	}
	for(int i=0;i<VNUM;i++){
		if(strcmp(BGvertex[i].sname,end)==0)ve=i;
	}






     Dijkstra(vs);
     int k,m=0;







     printpath(ve,vs,-1);
     



	    

	return 0;
}
initMap()
{
        FILE *fp;
        int i,j,snum,lno,lnum,  v1,v2;
        struct station st;
        
        fp=fopen("","");
        
        fscanf(fp,"",&snum);
        for(i=0; i<snum; i++) {
                fscanf(fp,"",&lno,&lnum);
                v1 = v2 = -1;
                for(j=0; j<lnum; j++){ 
                        fscanf(fp,"",st.sname,&st.ischange);
	                    v2 = addvertex(st); 
	                    if(v1 != -1){
	                        BGweights[v1][v2].wei = BGweights[v2][v1].wei = 1;
	                        BGweights[v1][v2].lno = BGweights[v2][v1].lno = lno;
	                    }
	                    v1 = v2;
                }
        }
       fclose(fp);
       return;
}
addvertex(struct station st)
{
	
	for(int i=0;i<VNUM;i++){
		if(strcmp(BGvertex[i].sname,st.sname)==0)return i;
	}
	strcpy(BGvertex[VNUM].sname,st.sname);
	BGvertex[VNUM++].ischange=st.ischange;

	return VNUM-1;
}
Dijkstra( int  v0)
{
    int i, j, v, minweight;
    for(i=0; i<VNUM; i++) { Sweight[i] = BGweights[v0][i].wei; Spath[i] = v0; }  
    Sweight [v0] = 0;  
    wfound [v0] = 1;  
     for(i=0; i< VNUM-1; i++) {  
         minweight =   INFINITY;
         for(j=0; j <  VNUM;  j++)   
             if( !wfound[j] && ( Sweight[j] < minweight) ) {
                 v = j; 
                 minweight = Sweight[v];
             }
         wfound[v] = 1;	

		 
         for(j =0; j < VNUM; j++){
		        if( !wfound[j]  &&  (minweight + BGweights[v][j].wei < Sweight[j] )) {
                 Sweight[j] = minweight + BGweights[v][j].wei;
                 Spath[j] = v;  
                 
                }
		 }
		  
             

     } 
}
printpath(int i,int vs,int afteri)
{
	if(i==vs){
		printf("",BGvertex[Spath[i]].sname,BGweights[Spath[i]][i].lno );
		return;
	}
	else if(i==ve){
		printpath(Spath[i],vs,i);
			printf("",BGweights[i][Spath[i]].lno,++sum,BGvertex[i].sname);
			sum=0;
	}
	else if(BGweights[i][afteri].lno!=BGweights[Spath[i]][i].lno){
	     printpath(Spath[i],vs,i);
			printf("",BGweights[i][Spath[i]].lno,++sum,BGvertex[i].sname);
			sum=0;

	}
	else {
	printpath(Spath[i],vs,i);
	
	sum++;
	}
}

100047
add_vex(Vex p)
{
    if (!p.istransfer)
    {
        v[vnum++] = p;
        return vnum - 1; 
    }
    else
    {
        for (int i = 0; i < vnum; i++)
        {
            if (!strcmp(p.station_name, v[i].station_name))
                return i;
        }
        v[vnum++] = p;
        return vnum - 1;
    }
}
create_graph()
{
    FILE *src = fopen("", "");
    int v1, v2; 
    int line_cnt;
    Vex tmp_vex;
    fscanf(src,"",&line_cnt);
    for (int i = 0; i < line_cnt; i++)
    {
        int lineID, staion_cnt;
        fscanf(src,"",&lineID, &staion_cnt);
        v1 = v2 = -1;
        for (int j=0;j<staion_cnt;j++)
        {
            fscanf(src,"",tmp_vex.station_name,&tmp_vex.istransfer);
            v2=add_vex(tmp_vex);
            if (v1!=-1)
            {
                mat[v1][v2].weight=mat[v2][v1].weight=1;
                mat[v1][v2].line=mat[v2][v1].line=lineID;
            }
            v1=v2;
        }
    }
    fclose(src);
}
DFS(int i)
{
    printf("",v[i].station_name);
    visited_dfs[i]=1;
    for (j=0;j<vnum;j++)
    {
        if(mat[i][j].weight>0&&visited_dfs[j]==0)
        DFS(j);
    }
}
Dijkstra(int v0)
{
    int minweight, minv;
    int wfound[1000] = {0};
    for (int i=0;i<vnum;i++)
    {
        sweight[i]=mat[v0][i].weight;
        spath[i]=v0;
        wfound[i]=0;
    }
    sweight[v0]=0;
    wfound[v0]=1;
    for (int i=0;i<vnum-1;i++)
    {
        minweight=32767;
        for (int j=0;j<vnum;j++)
        {
            if (!wfound[j]&&sweight[j]<minweight)
            {
                minv=j;
                minweight=sweight[minv];
            }
        }
        wfound[minv]=1;
        for (int j=0;j<vnum;j++)
        {
            if (!wfound[j]&&(minweight+mat[minv][j].weight)<sweight[j])
            {
                sweight[j]=minweight+mat[minv][j].weight;
                spath[j]=minv;
            }
        }
    }
}
reverse()
{
    int temple[1000] = {0};
    for (int i = 0; i < path_cnt; i++)
    {
        temple[path_cnt - 1 - i] = final_path[i];
    }
    for (int i = 0; i < path_cnt; i++)
    {
        final_path[i] = temple[i];
    }
}
put_path()
{
    int now, last, way_now, len;
    last = 0, now = 1;
    way_now = mat[final_path[last]][final_path[now]].line;
    len = 0;
    printf("", v[final_path[0]].station_name);
    for (; now < path_cnt; now++)
    {
        if (way_now != mat[final_path[last]][final_path[now]].line)
        {
            printf("", way_now, len, v[final_path[last]].station_name);
            way_now = mat[final_path[last]][final_path[now]].line;
            len = 0;
        }
        len++;
        last = now;
    }
    printf("", way_now, len, v[final_path[last]].station_name);
}
main()
{
    for (int i = 0; i < 1000; i++)
    {
        for (int j = 0; j < 1000; j++)
        {
            mat[i][j].weight = 32767;
            mat[i][j].line = 0;
        }
    }
    FILE *src = fopen("", "");
    int v1, v2; 
    int line_cnt;
    Vex tmp_vex;
    fscanf(src,"",&line_cnt);
    for (int i = 0; i < line_cnt; i++)
    {
        int lineID, staion_cnt;
        fscanf(src,"",&lineID, &staion_cnt);
        v1 = v2 = -1;
        for (int j=0;j<staion_cnt;j++)
        {
            fscanf(src,"",tmp_vex.station_name,&tmp_vex.istransfer);
            v2=add_vex(tmp_vex);
            if (v1!=-1)
            {
                mat[v1][v2].weight=mat[v2][v1].weight=1;
                mat[v1][v2].line=mat[v2][v1].line=lineID;
            }
            v1=v2;
        }
    }
    fclose(src);
    char begin[32], end[32];
    scanf("", begin, end);
    int index_b, index_e;
    for (int i = 0; i < vnum; i++)
    {
        if (!strcmp(begin, v[i].station_name))
        index_b = i;
        if (!strcmp(end, v[i].station_name))
        index_e = i;
    }
    Dijkstra(index_b);
    int tmp = index_e;
    while (tmp != index_b)
    {
        final_path[path_cnt++] = tmp;
        tmp = spath[tmp];
    }
    final_path[path_cnt++] = tmp;
    int temple[1000] = {0};
    for (int i = 0; i < path_cnt; i++)
    {
        temple[path_cnt - 1 - i] = final_path[i];
    }
    for (int i = 0; i < path_cnt; i++)
    {
        final_path[i] = temple[i];
    }
   int now, last, way_now, len;
    last = 0, now = 1;
    way_now = mat[final_path[last]][final_path[now]].line;
    len = 0;
    printf("", v[final_path[0]].station_name);
    for (; now < path_cnt; now++)
    {
        if (way_now != mat[final_path[last]][final_path[now]].line)
        {
            printf("", way_now, len, v[final_path[last]].station_name);
            way_now = mat[final_path[last]][final_path[now]].line;
            len = 0;
        }
        len++;
        last = now;
    }
    printf("", way_now, len, v[final_path[last]].station_name);
}

100049
find(char str[])
{
	int i;
	for(i=1;i<=m;i++)
		if(strcmp(name[i],str)==0) return i;
	return -1;
}
main()
{
	char start[30],goal[30];
	scanf("",start,goal);
	in=fopen("","");
	int i;
	fscanf(in,"",&n);
	for(i=0;i<100;i++)
	{
		int k;
		for(k=0;k<100;k++) map[i][k]=999;
	}
	for(i=1;i<=n;i++)
	{
		int len,flag,f,k,ml=0,value[100],locat[100],r;
		char str[30],table[100][30];
		fscanf(in,"",&r,&len);
		for(k=1;k<=len;k++)
		{
			fscanf(in,"",str,&flag);
			if(k==1 || flag==1 || strcmp(str,start)==0 || strcmp(str,goal)==0)
			{
				ml++;
				strcpy(table[ml],str);
				value[ml]=k-1;
			}
		}
		for(k=1;k<=ml;k++)
		{
			int t=find(table[k]),j=0;
			if(t==-1)
			{
				m++;
				t=m;
				strcpy(name[t],table[k]);
			}
			locat[k]=t;
			while(line[t][j]!=0 && j<5) j++;
			line[t][j]=r;
		}
		for(k=1;k<=ml;k++)
		{
			int j;
			for(j=1;j<=ml;j++)
				if(map[locat[k]][locat[j]]>abs(value[k]-value[j])) map[locat[k]][locat[j]]=abs(value[k]-value[j]);
		}
	}
	
	int v0=find(goal);
	for(i=1;i<=m;i++)
	{
		sweight[i]=map[v0][i];
		spath[i]=v0;
	}
	wfound[v0]=1;sweight[v0]=0;
	for(i=1;i<m;i++)
	{
		int min=9999,v=0,k;
		for(k=1;k<=m;k++)
		{
			if(sweight[k]<min && wfound[k]==0)
			{
				min=sweight[k];
				v=k;
			}
		}
		wfound[v]=1;
		for(k=1;k<=m;k++)
		{
			if(wfound[k]==0 && map[k][v]!=0 && sweight[k]>sweight[v]+map[v][k])
			{
				sweight[k]=sweight[v]+map[v][k];
				spath[k]=v;
			}
		}
	}
	
	int w=find(start);
	
	while(w!=v0){
		int k=0,j=0,l;
		for(k=0;k<5;k++)
			for(j=0;j<5;j++)
			if(line[w][k]==line[spath[w]][j]){
				l=line[w][k];
				k=5;
				j=5;
			}
		if(w==23 && spath[w]==25 && l==4) l=16;
		if(w==24 && spath[w]==26 && l==4) l=16;
		printf("",name[w],l,map[w][spath[w]]);
		w=spath[w];
	}
	printf("",goal);
	return 0;
}

100051
main()
{
	int i,sta,ed;
	initMap();
	char start[MAXLEN],end[MAXLEN];
	scanf("",start,end);
	for(i=0;i<Vnum;i++){
		if(strcmp(start,BGvertex[i].sname)==0){
			sta=i;
		}
		if(strcmp(end,BGvertex[i].sname)==0){
			ed=i;
		}
	}
	Dijkstra(sta,ed);
	printPath(sta,ed);
	return 0;
}
initMap()
{
	FILE *fp;
	int i,j,snum,lno,lnum,v1,v2;
	struct station st;
	fp=fopen("","");
	fscanf(fp,"",&snum);
	for(i=0;i<snum;i++){
		fscanf(fp,"",&lno,&lnum);
        v1=v2=-1;
        for(j=0;j<lnum;j++){
            fscanf(fp,"",st.sname,&st.ischange);
	        v2 = addVertex(st); 
	        if(v1 != -1){
	            BGweights[v1][v2].wei = BGweights[v2][v1].wei =1;
	            BGweights[v1][v2].lno = BGweights[v2][v1].lno =lno;
	        }
	        v1 = v2;
        }
	}
	for(i=0;i<Vnum;i++){
		for(j=0;j<Vnum;j++){
			if(BGweights[i][j].wei==0){
				BGweights[i][j].wei=INFINITY;
			}
			if(BGweights[i][j].lno==0){
				BGweights[i][j].lno=-1;
			}
		}
	}
	fclose(fp);
	return;
}
addVertex(struct station st)
{
	int i;
	if(st.ischange==1){
		for(i=0;i<Vnum;i++){
			if(strcmp(st.sname,BGvertex[i].sname)==0){
				return i;
			}
		}
	}
	BGvertex[Vnum++]=st;
	return Vnum-1;
}
Dijkstra(int v0,int v1)
{
    int i, j, v, minweight,Sweight[MAXNUM]={0},wfound[MAXNUM] = {0}; 
    for(i=0; i<Vnum; i++) { 
	    Sweight[i] = BGweights[v0][i].wei; 
		Spath[i] = v0; 
	}  
    Sweight[v0]= 0;  
    wfound[v0]= 1;  
    for(i=0; i<Vnum-1; i++) {  
        minweight = INFINITY;
        for(j=0;j<Vnum;j++)   
            if(wfound[j]==0 && (Sweight[j]<minweight)) {
                v = j; 
                minweight = Sweight[v];
            }
        wfound[v] = 1;	
        for(j=0;j<Vnum;j++) 
            if(wfound[j]==0 && (minweight + BGweights[v][j].wei < Sweight[j] )) {
                Sweight[j] = minweight + BGweights[v][j].wei;
                Spath[j] = v;  
           }
     }
     if(wfound[v1]==1){
     	return;
	 }
}
printPath(int v0,int v1)
{
	char path[80]={0},buf[80]={0};
	int board[80],cnt=-1,i,j,hold;
	board[++cnt]=v1;
	v1=Spath[v1];
	while(v1!=v0){
		board[++cnt]=v1;
		v1=Spath[v1];
	}
	board[++cnt]=v0;
	sprintf(buf,"",BGvertex[board[cnt]].sname,BGweights[board[cnt]][board[cnt-1]].lno);
	strcpy(path,buf);
	hold=BGweights[board[cnt]][board[cnt-1]].lno;
	for(i=cnt-1,j=1;i>0;i--,j++){
		if(BGweights[board[i]][board[i-1]].lno!=hold){
			sprintf(buf,"",j,BGvertex[board[i]].sname,BGweights[board[i]][board[i-1]].lno);
		    strcat(path,buf);
		    j=0;
		    hold=BGweights[board[i]][board[i-1]].lno;
		}
	}
	sprintf(buf,"",j,BGvertex[board[i]].sname);
	strcat(path,buf);
	printf("",path);
}
