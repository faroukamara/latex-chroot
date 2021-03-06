%% sgbx0008.mp
%% Copyright 2006 Tommy Ekola <tek@kth.se>
%
% This work may be distributed and/or modified under the conditions of
% the LaTeX Project Public License, either version 1.3 of this license
% or (at your option) any later version.  The latest version of this
% license is in http://www.latex-project.org/lppl.txt
%
% This work has the LPPL maintenance status `maintained'.  The Current
% Maintainer of this work is Tommy Ekola.  The Base Interpreter is
% MetaPost.

vardef setup_twowayoldarrow (expr source_file, cmdname) =

  scantokens ("input tgbx0000");

  scantokens ("input " & source_file);

  expandafter def scantokens cmdname expr p =
    scantokens (cmdname & "__sgbxww")(p)
  enddef;

  expandafter vardef scantokens (cmdname & "__sgbxww " & "(expr apth) " &
    "text text_ = " &
  
    "save math_spread, x_height, u, rule_thickness, bar, math_axis," &
    "     asc_height, eps, fudge, crisp, hair;" &

    "math_spread     :=" & decimal math_spread & ";" &
    "x_height#       :=" & decimal x_height# & ";" &
    "u#              :=" & decimal u# & ";" &
    "rule_thickness# :=" & decimal rule_thickness# & ";" &
    "bar#            :=" & decimal bar# & ";" &
    "math_axis#      :=" & decimal math_axis# & ";" &
    "asc_height#     :=" & decimal asc_height# & ";" &
    "eps             :=" & decimal eps & ";" &
    "fudge           :=" & decimal fudge & ";" &
    "crisp#          :=" & decimal crisp# & ";" &
    "hair#           :=" & decimal hair# & ";")
    
    save prevpen;
    prevpen:=savepen;

    save x,y;
    numeric x[], x[]', x[]l, x[]'l, x[]r, x[]'r,
            y[], y[]', y[]l, y[]'l, y[]r, y[]'r;
    save spread, w;
    numeric spread, w;
  
    if crisp#>fudge*hair#:
      crisp#:=fudge*hair#;
    fi
    pickup if crisp#=0: nullpen else: pencircle scaled crisp# fi;

    spread = math_spread[.45x_height#, .55x_height#];
    w = 18u#;
  
    penpos1(rule_thickness#, 90); penpos2(rule_thickness#, 90);
    penpos3(bar#, 0);             penpos4(bar#, 0);
    y0=y1=y2=math_axis#; x1-.5rule_thickness#=u#; rt x0=w-u#;
    y3-y0=y0-y4=.24asc_height#+eps;
    x3=x4=x0-3u#-eps;
    penpos5(bar#, angle(z4-z0)); z5l=z0;
    penpos6(bar#, angle(z3-z0)); z6l=z0;
    z9=.381966[.5[z3,z4],z0];
  
    save pp; path pp;   pp = z4l{z9-z4}..z6r;
    save t; numeric t;  t = xpart(pp intersectiontimes ((0,y2l)--(w,y2l)));
    x2=xpart point t of pp;
  
    save mapto, n;
    vardef mapto(text t) =
      hide(numeric n; n:=0;
           numeric x,x_[],y,y_[];
           for z=t: z_[incr n]:=z; endfor;
           transform T;
           z_2 = z_1 transformed T;
           z_4 = z_3 transformed T;
           z_6 = z_5 transformed T;)
      T
    enddef;
  
    save T;   transform T;
    save tt;  numeric tt;  tt  = arctime(arclength apth - (x0-x9)) of apth;
    save ttt; numeric ttt; ttt = arctime(arclength apth - (x0-x2)) of apth;
    save ss;  numeric ss;  ss  = arctime x0-x9 of apth;
    save sss; numeric sss; sss = arctime x0-x2 of apth;

    % Draw the right half of the arrow head

    save right_texarrowhead, pa;
    vardef right_texarrowhead(expr T,s) =
      (subpath(0, xpart ((z0..{z4-z9}z4r) intersectiontimes
	              (point s of pp -- point s of pp + (2rule_thickness#,0))))
	of (z0..{z4-z9}z4r)--subpath(s,t) of pp--z2l) transformed T
    enddef;
    
    if   arclength apth = 0:
      T:=identity shifted (point (length apth) of apth - z0);
    elseif arclength apth < x0-x3l:
      T:=identity rotatedaround(z0,angle (direction (length apth) of apth))
                  shifted (point (length apth) of apth - z0);
    else:
      T:=mapto(z0,
               point (length apth) of apth,
               z2,
               point ttt of apth,
               z9-(0,3rule_thickness#),
               point tt of apth - 3rule_thickness#
                                   *(unitvector (direction tt of apth) 
                                   rotated 90));
    fi

    save f,s;
    vardef f(expr s) =
      length(point s of (pp transformed T) - point tt of apth)
      < length(point 0 of pp - z9)
    enddef;

    if f(0) or (arclength apth < x0-x3l): s := 0;
    else:    s := solve f(length pp, 0);
    fi

    path pa;
    pa := right_texarrowhead(T,s);		     

    if     arclength apth = 0:
      T:=identity reflectedabout ((x0,y3),(x0,y4))
                  shifted (point (length 0) of apth -z0);
    elseif arclength apth < x0-x3l:
      T:=identity reflectedabout ((x0,y3),(x0,y4))
                  rotatedaround(z0, angle direction (length 0) of apth)
                  shifted (point (length 0) of apth - z0);
    else:
      T:=mapto(z0,
    	       point 0 of apth,
               z2,
               point sss of apth,
               z9-(0,3rule_thickness#),
               point ss of apth - 3rule_thickness#
                                  *(unitvector (direction ss of apth)
                                  rotated 90));
    fi

    vardef f(expr s) =
      length(point s of (pp transformed T) - point ss of apth)
      < length(point 0 of pp - z9)
    enddef;

    if f(0) or (arclength apth < x0-x3l): s := 0;
    else:    s := solve f(length pp, 0);
    fi

    save pc; path pc;
    pc := right_texarrowhead(T,s);		     
    
    % Draw the left part of the arrow head

    pp := (z3l{z9-z3}..z5r);
    save pq; path pq; pq := (z3r{z9-z3}..z0);
    
    save left_texarrowhead, pb;
    vardef left_texarrowhead(expr T, s) =
      (z2r--subpath(t,s) of pp
	--subpath(xpart ( pq intersectiontimes
	            (point s of pp -- point s of pp + (2rule_thickness#,0)))
	          ,length pq) of pq) transformed T
    enddef;
    
    if   arclength apth = 0:
      T:=identity shifted (point (length apth) of apth - z0);
    elseif arclength apth < x0-x3l:
      T:=identity rotatedaround(z0,angle (direction (length apth) of apth))
                  shifted (point (length apth) of apth - z0);
    else:
      T:=mapto(z0,
               point (length apth) of apth,
               z2,
               point ttt of apth,
               z9+(0,3rule_thickness#),
               point tt of apth + 3rule_thickness#
                                   *(unitvector (direction tt of apth) 
                                   rotated 90));
    fi

    vardef f(expr s) =
      length(point s of (pp transformed T) - point tt of apth)
      < length(point 0 of pp - z9)
    enddef;

    if f(0) or (arclength apth < x0-x3l): s := 0;
    else:    s := solve f(length pp, 0);
    fi

    path pb;
    pb := left_texarrowhead(T,s);

    if     arclength apth = 0:
      T:=identity reflectedabout ((x0,y3),(x0,y4))
                  shifted (point (length 0) of apth -z0);
    elseif arclength apth < x0-x3l:
      T:=identity reflectedabout ((x0,y3),(x0,y4))
                  rotatedaround(z0, angle direction (length 0) of apth)
                  shifted (point (length 0) of apth - z0);
    else:
      T:=mapto(z0,
    	       point 0 of apth,
               z2,
               point sss of apth,
               z9+(0,3rule_thickness#),
               point ss of apth + 3rule_thickness#
                                  *(unitvector (direction ss of apth)
                                  rotated 90));
    fi

    vardef f(expr s) =
      length(point s of (pp transformed T) - point ss of apth)
      < length(point 0 of pp - z9)
    enddef;

    if f(0) or (arclength apth < x0-x3l): s := 0;
    else:    s := solve f(length pp, 0);
    fi

    save pd; path pd;
    pd := left_texarrowhead(T,s);		     

    filldraw pa--pb--cycle text_;
    filldraw pc--pd--cycle text_;

    if arclength apth > 2(x0-x2):
      draw subpath(sss,ttt) of apth withpen pencircle scaled rule_thickness#
           text_;
    fi
	 
    pickup prevpen;
  
  enddef;

enddef;