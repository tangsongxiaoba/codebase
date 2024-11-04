/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0xfbc00daa */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "/media/shared/co/verilog/P1/alternate.v";
static int ng1[] = {0, 0};
static int ng2[] = {1, 0};
static int ng3[] = {2, 0};
static int ng4[] = {5, 0};
static int ng5[] = {3, 0};
static int ng6[] = {4, 0};
static int ng7[] = {6, 0};
static int ng8[] = {7, 0};



static void Always_32_0(char *t0)
{
    char t6[8];
    char t21[8];
    char t37[8];
    char t45[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    unsigned int t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    char *t12;
    char *t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t22;
    char *t23;
    unsigned int t24;
    unsigned int t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    unsigned int t29;
    unsigned int t30;
    unsigned int t31;
    unsigned int t32;
    unsigned int t33;
    unsigned int t34;
    unsigned int t35;
    char *t36;
    char *t38;
    unsigned int t39;
    unsigned int t40;
    unsigned int t41;
    unsigned int t42;
    unsigned int t43;
    char *t44;
    unsigned int t46;
    unsigned int t47;
    unsigned int t48;
    char *t49;
    char *t50;
    char *t51;
    unsigned int t52;
    unsigned int t53;
    unsigned int t54;
    unsigned int t55;
    unsigned int t56;
    unsigned int t57;
    unsigned int t58;
    char *t59;
    char *t60;
    unsigned int t61;
    unsigned int t62;
    unsigned int t63;
    unsigned int t64;
    unsigned int t65;
    unsigned int t66;
    unsigned int t67;
    unsigned int t68;
    int t69;
    int t70;
    unsigned int t71;
    unsigned int t72;
    unsigned int t73;
    unsigned int t74;
    unsigned int t75;
    unsigned int t76;
    char *t77;
    unsigned int t78;
    unsigned int t79;
    unsigned int t80;
    unsigned int t81;
    unsigned int t82;
    char *t83;
    char *t84;

LAB0:    t1 = (t0 + 3160U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(32, ng0);
    t2 = (t0 + 3976);
    *((int *)t2) = 1;
    t3 = (t0 + 3192);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(32, ng0);

LAB5:    xsi_set_current_line(33, ng0);
    t4 = (t0 + 1208U);
    t5 = *((char **)t4);
    memset(t6, 0, 8);
    t4 = (t5 + 4);
    t7 = *((unsigned int *)t4);
    t8 = (~(t7));
    t9 = *((unsigned int *)t5);
    t10 = (t9 & t8);
    t11 = (t10 & 1U);
    if (t11 != 0)
        goto LAB6;

LAB7:    if (*((unsigned int *)t4) != 0)
        goto LAB8;

LAB9:    t13 = (t6 + 4);
    t14 = *((unsigned int *)t6);
    t15 = *((unsigned int *)t13);
    t16 = (t14 || t15);
    if (t16 > 0)
        goto LAB10;

LAB11:    memcpy(t45, t6, 8);

LAB12:    t77 = (t45 + 4);
    t78 = *((unsigned int *)t77);
    t79 = (~(t78));
    t80 = *((unsigned int *)t45);
    t81 = (t80 & t79);
    t82 = (t81 != 0);
    if (t82 > 0)
        goto LAB24;

LAB25:    xsi_set_current_line(36, ng0);
    t2 = (t0 + 1208U);
    t3 = *((char **)t2);
    memset(t6, 0, 8);
    t2 = (t3 + 4);
    t7 = *((unsigned int *)t2);
    t8 = (~(t7));
    t9 = *((unsigned int *)t3);
    t10 = (t9 & t8);
    t11 = (t10 & 1U);
    if (t11 != 0)
        goto LAB31;

LAB29:    if (*((unsigned int *)t2) == 0)
        goto LAB28;

LAB30:    t4 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t4) = 1;

LAB31:    t5 = (t6 + 4);
    t12 = (t3 + 4);
    t14 = *((unsigned int *)t3);
    t15 = (~(t14));
    *((unsigned int *)t6) = t15;
    *((unsigned int *)t5) = 0;
    if (*((unsigned int *)t12) != 0)
        goto LAB33;

LAB32:    t27 = *((unsigned int *)t6);
    *((unsigned int *)t6) = (t27 & 1U);
    t28 = *((unsigned int *)t5);
    *((unsigned int *)t5) = (t28 & 1U);
    t13 = (t6 + 4);
    t29 = *((unsigned int *)t13);
    t30 = (~(t29));
    t31 = *((unsigned int *)t6);
    t32 = (t31 & t30);
    t33 = (t32 != 0);
    if (t33 > 0)
        goto LAB34;

LAB35:    xsi_set_current_line(40, ng0);

LAB38:    xsi_set_current_line(41, ng0);
    t2 = (t0 + 1928);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);

LAB39:    t5 = ((char*)((ng1)));
    t69 = xsi_vlog_unsigned_case_compare(t4, 3, t5, 32);
    if (t69 == 1)
        goto LAB40;

LAB41:    t2 = ((char*)((ng2)));
    t69 = xsi_vlog_unsigned_case_compare(t4, 3, t2, 32);
    if (t69 == 1)
        goto LAB42;

LAB43:    t2 = ((char*)((ng3)));
    t69 = xsi_vlog_unsigned_case_compare(t4, 3, t2, 32);
    if (t69 == 1)
        goto LAB44;

LAB45:    t2 = ((char*)((ng5)));
    t69 = xsi_vlog_unsigned_case_compare(t4, 3, t2, 32);
    if (t69 == 1)
        goto LAB46;

LAB47:    t2 = ((char*)((ng6)));
    t69 = xsi_vlog_unsigned_case_compare(t4, 3, t2, 32);
    if (t69 == 1)
        goto LAB48;

LAB49:    t2 = ((char*)((ng4)));
    t69 = xsi_vlog_unsigned_case_compare(t4, 3, t2, 32);
    if (t69 == 1)
        goto LAB50;

LAB51:    t2 = ((char*)((ng7)));
    t69 = xsi_vlog_unsigned_case_compare(t4, 3, t2, 32);
    if (t69 == 1)
        goto LAB52;

LAB53:    t2 = ((char*)((ng8)));
    t69 = xsi_vlog_unsigned_case_compare(t4, 3, t2, 32);
    if (t69 == 1)
        goto LAB54;

LAB55:
LAB56:
LAB36:
LAB26:    goto LAB2;

LAB6:    *((unsigned int *)t6) = 1;
    goto LAB9;

LAB8:    t12 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t12) = 1;
    goto LAB9;

LAB10:    t17 = (t0 + 2088);
    t18 = (t17 + 56U);
    t19 = *((char **)t18);
    t20 = ((char*)((ng1)));
    memset(t21, 0, 8);
    t22 = (t19 + 4);
    t23 = (t20 + 4);
    t24 = *((unsigned int *)t19);
    t25 = *((unsigned int *)t20);
    t26 = (t24 ^ t25);
    t27 = *((unsigned int *)t22);
    t28 = *((unsigned int *)t23);
    t29 = (t27 ^ t28);
    t30 = (t26 | t29);
    t31 = *((unsigned int *)t22);
    t32 = *((unsigned int *)t23);
    t33 = (t31 | t32);
    t34 = (~(t33));
    t35 = (t30 & t34);
    if (t35 != 0)
        goto LAB16;

LAB13:    if (t33 != 0)
        goto LAB15;

LAB14:    *((unsigned int *)t21) = 1;

LAB16:    memset(t37, 0, 8);
    t38 = (t21 + 4);
    t39 = *((unsigned int *)t38);
    t40 = (~(t39));
    t41 = *((unsigned int *)t21);
    t42 = (t41 & t40);
    t43 = (t42 & 1U);
    if (t43 != 0)
        goto LAB17;

LAB18:    if (*((unsigned int *)t38) != 0)
        goto LAB19;

LAB20:    t46 = *((unsigned int *)t6);
    t47 = *((unsigned int *)t37);
    t48 = (t46 & t47);
    *((unsigned int *)t45) = t48;
    t49 = (t6 + 4);
    t50 = (t37 + 4);
    t51 = (t45 + 4);
    t52 = *((unsigned int *)t49);
    t53 = *((unsigned int *)t50);
    t54 = (t52 | t53);
    *((unsigned int *)t51) = t54;
    t55 = *((unsigned int *)t51);
    t56 = (t55 != 0);
    if (t56 == 1)
        goto LAB21;

LAB22:
LAB23:    goto LAB12;

LAB15:    t36 = (t21 + 4);
    *((unsigned int *)t21) = 1;
    *((unsigned int *)t36) = 1;
    goto LAB16;

LAB17:    *((unsigned int *)t37) = 1;
    goto LAB20;

LAB19:    t44 = (t37 + 4);
    *((unsigned int *)t37) = 1;
    *((unsigned int *)t44) = 1;
    goto LAB20;

LAB21:    t57 = *((unsigned int *)t45);
    t58 = *((unsigned int *)t51);
    *((unsigned int *)t45) = (t57 | t58);
    t59 = (t6 + 4);
    t60 = (t37 + 4);
    t61 = *((unsigned int *)t6);
    t62 = (~(t61));
    t63 = *((unsigned int *)t59);
    t64 = (~(t63));
    t65 = *((unsigned int *)t37);
    t66 = (~(t65));
    t67 = *((unsigned int *)t60);
    t68 = (~(t67));
    t69 = (t62 & t64);
    t70 = (t66 & t68);
    t71 = (~(t69));
    t72 = (~(t70));
    t73 = *((unsigned int *)t51);
    *((unsigned int *)t51) = (t73 & t71);
    t74 = *((unsigned int *)t51);
    *((unsigned int *)t51) = (t74 & t72);
    t75 = *((unsigned int *)t45);
    *((unsigned int *)t45) = (t75 & t71);
    t76 = *((unsigned int *)t45);
    *((unsigned int *)t45) = (t76 & t72);
    goto LAB23;

LAB24:    xsi_set_current_line(33, ng0);

LAB27:    xsi_set_current_line(34, ng0);
    t83 = (t0 + 1368U);
    t84 = *((char **)t83);
    t83 = (t0 + 2248);
    xsi_vlogvar_wait_assign_value(t83, t84, 0, 0, 1, 0LL);
    goto LAB26;

LAB28:    *((unsigned int *)t6) = 1;
    goto LAB31;

LAB33:    t16 = *((unsigned int *)t6);
    t24 = *((unsigned int *)t12);
    *((unsigned int *)t6) = (t16 | t24);
    t25 = *((unsigned int *)t5);
    t26 = *((unsigned int *)t12);
    *((unsigned int *)t5) = (t25 | t26);
    goto LAB32;

LAB34:    xsi_set_current_line(36, ng0);

LAB37:    xsi_set_current_line(37, ng0);
    t17 = ((char*)((ng1)));
    t18 = (t0 + 1928);
    xsi_vlogvar_wait_assign_value(t18, t17, 0, 0, 3, 0LL);
    xsi_set_current_line(38, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 2088);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    goto LAB36;

LAB40:    xsi_set_current_line(42, ng0);
    t12 = (t0 + 1368U);
    t13 = *((char **)t12);
    t12 = (t0 + 2248);
    t17 = (t12 + 56U);
    t18 = *((char **)t17);
    memset(t37, 0, 8);
    if (*((unsigned int *)t13) != *((unsigned int *)t18))
        goto LAB59;

LAB57:    t19 = (t13 + 4);
    t20 = (t18 + 4);
    if (*((unsigned int *)t19) != *((unsigned int *)t20))
        goto LAB59;

LAB58:    *((unsigned int *)t37) = 1;

LAB59:    memset(t21, 0, 8);
    t22 = (t37 + 4);
    t7 = *((unsigned int *)t22);
    t8 = (~(t7));
    t9 = *((unsigned int *)t37);
    t10 = (t9 & t8);
    t11 = (t10 & 1U);
    if (t11 != 0)
        goto LAB60;

LAB61:    if (*((unsigned int *)t22) != 0)
        goto LAB62;

LAB63:    t36 = (t21 + 4);
    t14 = *((unsigned int *)t21);
    t15 = *((unsigned int *)t36);
    t16 = (t14 || t15);
    if (t16 > 0)
        goto LAB64;

LAB65:    t24 = *((unsigned int *)t21);
    t25 = (~(t24));
    t26 = *((unsigned int *)t36);
    t27 = (t25 || t26);
    if (t27 > 0)
        goto LAB66;

LAB67:    if (*((unsigned int *)t36) > 0)
        goto LAB68;

LAB69:    if (*((unsigned int *)t21) > 0)
        goto LAB70;

LAB71:    memcpy(t6, t44, 8);

LAB72:    t49 = (t0 + 1928);
    xsi_vlogvar_wait_assign_value(t49, t6, 0, 0, 3, 0LL);
    goto LAB56;

LAB42:    xsi_set_current_line(43, ng0);
    t3 = (t0 + 1368U);
    t5 = *((char **)t3);
    t3 = (t0 + 2248);
    t12 = (t3 + 56U);
    t13 = *((char **)t12);
    memset(t37, 0, 8);
    if (*((unsigned int *)t5) != *((unsigned int *)t13))
        goto LAB75;

LAB73:    t17 = (t5 + 4);
    t18 = (t13 + 4);
    if (*((unsigned int *)t17) != *((unsigned int *)t18))
        goto LAB75;

LAB74:    *((unsigned int *)t37) = 1;

LAB75:    memset(t21, 0, 8);
    t19 = (t37 + 4);
    t7 = *((unsigned int *)t19);
    t8 = (~(t7));
    t9 = *((unsigned int *)t37);
    t10 = (t9 & t8);
    t11 = (t10 & 1U);
    if (t11 != 0)
        goto LAB76;

LAB77:    if (*((unsigned int *)t19) != 0)
        goto LAB78;

LAB79:    t22 = (t21 + 4);
    t14 = *((unsigned int *)t21);
    t15 = *((unsigned int *)t22);
    t16 = (t14 || t15);
    if (t16 > 0)
        goto LAB80;

LAB81:    t24 = *((unsigned int *)t21);
    t25 = (~(t24));
    t26 = *((unsigned int *)t22);
    t27 = (t25 || t26);
    if (t27 > 0)
        goto LAB82;

LAB83:    if (*((unsigned int *)t22) > 0)
        goto LAB84;

LAB85:    if (*((unsigned int *)t21) > 0)
        goto LAB86;

LAB87:    memcpy(t6, t36, 8);

LAB88:    t38 = (t0 + 1928);
    xsi_vlogvar_wait_assign_value(t38, t6, 0, 0, 3, 0LL);
    goto LAB56;

LAB44:    xsi_set_current_line(44, ng0);
    t3 = (t0 + 1368U);
    t5 = *((char **)t3);
    t3 = (t0 + 2248);
    t12 = (t3 + 56U);
    t13 = *((char **)t12);
    memset(t37, 0, 8);
    if (*((unsigned int *)t5) != *((unsigned int *)t13))
        goto LAB91;

LAB89:    t17 = (t5 + 4);
    t18 = (t13 + 4);
    if (*((unsigned int *)t17) != *((unsigned int *)t18))
        goto LAB91;

LAB90:    *((unsigned int *)t37) = 1;

LAB91:    memset(t21, 0, 8);
    t19 = (t37 + 4);
    t7 = *((unsigned int *)t19);
    t8 = (~(t7));
    t9 = *((unsigned int *)t37);
    t10 = (t9 & t8);
    t11 = (t10 & 1U);
    if (t11 != 0)
        goto LAB92;

LAB93:    if (*((unsigned int *)t19) != 0)
        goto LAB94;

LAB95:    t22 = (t21 + 4);
    t14 = *((unsigned int *)t21);
    t15 = *((unsigned int *)t22);
    t16 = (t14 || t15);
    if (t16 > 0)
        goto LAB96;

LAB97:    t24 = *((unsigned int *)t21);
    t25 = (~(t24));
    t26 = *((unsigned int *)t22);
    t27 = (t25 || t26);
    if (t27 > 0)
        goto LAB98;

LAB99:    if (*((unsigned int *)t22) > 0)
        goto LAB100;

LAB101:    if (*((unsigned int *)t21) > 0)
        goto LAB102;

LAB103:    memcpy(t6, t36, 8);

LAB104:    t38 = (t0 + 1928);
    xsi_vlogvar_wait_assign_value(t38, t6, 0, 0, 3, 0LL);
    goto LAB56;

LAB46:    xsi_set_current_line(45, ng0);
    t3 = ((char*)((ng5)));
    t5 = (t0 + 1928);
    xsi_vlogvar_wait_assign_value(t5, t3, 0, 0, 3, 0LL);
    goto LAB56;

LAB48:    xsi_set_current_line(46, ng0);
    t3 = (t0 + 1368U);
    t5 = *((char **)t3);
    t3 = (t0 + 2248);
    t12 = (t3 + 56U);
    t13 = *((char **)t12);
    memset(t37, 0, 8);
    if (*((unsigned int *)t5) != *((unsigned int *)t13))
        goto LAB107;

LAB105:    t17 = (t5 + 4);
    t18 = (t13 + 4);
    if (*((unsigned int *)t17) != *((unsigned int *)t18))
        goto LAB107;

LAB106:    *((unsigned int *)t37) = 1;

LAB107:    memset(t21, 0, 8);
    t19 = (t37 + 4);
    t7 = *((unsigned int *)t19);
    t8 = (~(t7));
    t9 = *((unsigned int *)t37);
    t10 = (t9 & t8);
    t11 = (t10 & 1U);
    if (t11 != 0)
        goto LAB108;

LAB109:    if (*((unsigned int *)t19) != 0)
        goto LAB110;

LAB111:    t22 = (t21 + 4);
    t14 = *((unsigned int *)t21);
    t15 = *((unsigned int *)t22);
    t16 = (t14 || t15);
    if (t16 > 0)
        goto LAB112;

LAB113:    t24 = *((unsigned int *)t21);
    t25 = (~(t24));
    t26 = *((unsigned int *)t22);
    t27 = (t25 || t26);
    if (t27 > 0)
        goto LAB114;

LAB115:    if (*((unsigned int *)t22) > 0)
        goto LAB116;

LAB117:    if (*((unsigned int *)t21) > 0)
        goto LAB118;

LAB119:    memcpy(t6, t36, 8);

LAB120:    t38 = (t0 + 1928);
    xsi_vlogvar_wait_assign_value(t38, t6, 0, 0, 3, 0LL);
    goto LAB56;

LAB50:    xsi_set_current_line(47, ng0);
    t3 = (t0 + 1368U);
    t5 = *((char **)t3);
    t3 = (t0 + 2248);
    t12 = (t3 + 56U);
    t13 = *((char **)t12);
    memset(t37, 0, 8);
    if (*((unsigned int *)t5) != *((unsigned int *)t13))
        goto LAB123;

LAB121:    t17 = (t5 + 4);
    t18 = (t13 + 4);
    if (*((unsigned int *)t17) != *((unsigned int *)t18))
        goto LAB123;

LAB122:    *((unsigned int *)t37) = 1;

LAB123:    memset(t21, 0, 8);
    t19 = (t37 + 4);
    t7 = *((unsigned int *)t19);
    t8 = (~(t7));
    t9 = *((unsigned int *)t37);
    t10 = (t9 & t8);
    t11 = (t10 & 1U);
    if (t11 != 0)
        goto LAB124;

LAB125:    if (*((unsigned int *)t19) != 0)
        goto LAB126;

LAB127:    t22 = (t21 + 4);
    t14 = *((unsigned int *)t21);
    t15 = *((unsigned int *)t22);
    t16 = (t14 || t15);
    if (t16 > 0)
        goto LAB128;

LAB129:    t24 = *((unsigned int *)t21);
    t25 = (~(t24));
    t26 = *((unsigned int *)t22);
    t27 = (t25 || t26);
    if (t27 > 0)
        goto LAB130;

LAB131:    if (*((unsigned int *)t22) > 0)
        goto LAB132;

LAB133:    if (*((unsigned int *)t21) > 0)
        goto LAB134;

LAB135:    memcpy(t6, t36, 8);

LAB136:    t38 = (t0 + 1928);
    xsi_vlogvar_wait_assign_value(t38, t6, 0, 0, 3, 0LL);
    goto LAB56;

LAB52:    xsi_set_current_line(48, ng0);
    t3 = (t0 + 1368U);
    t5 = *((char **)t3);
    t3 = (t0 + 2248);
    t12 = (t3 + 56U);
    t13 = *((char **)t12);
    memset(t37, 0, 8);
    if (*((unsigned int *)t5) != *((unsigned int *)t13))
        goto LAB139;

LAB137:    t17 = (t5 + 4);
    t18 = (t13 + 4);
    if (*((unsigned int *)t17) != *((unsigned int *)t18))
        goto LAB139;

LAB138:    *((unsigned int *)t37) = 1;

LAB139:    memset(t21, 0, 8);
    t19 = (t37 + 4);
    t7 = *((unsigned int *)t19);
    t8 = (~(t7));
    t9 = *((unsigned int *)t37);
    t10 = (t9 & t8);
    t11 = (t10 & 1U);
    if (t11 != 0)
        goto LAB140;

LAB141:    if (*((unsigned int *)t19) != 0)
        goto LAB142;

LAB143:    t22 = (t21 + 4);
    t14 = *((unsigned int *)t21);
    t15 = *((unsigned int *)t22);
    t16 = (t14 || t15);
    if (t16 > 0)
        goto LAB144;

LAB145:    t24 = *((unsigned int *)t21);
    t25 = (~(t24));
    t26 = *((unsigned int *)t22);
    t27 = (t25 || t26);
    if (t27 > 0)
        goto LAB146;

LAB147:    if (*((unsigned int *)t22) > 0)
        goto LAB148;

LAB149:    if (*((unsigned int *)t21) > 0)
        goto LAB150;

LAB151:    memcpy(t6, t36, 8);

LAB152:    t38 = (t0 + 1928);
    xsi_vlogvar_wait_assign_value(t38, t6, 0, 0, 3, 0LL);
    goto LAB56;

LAB54:    xsi_set_current_line(49, ng0);
    t3 = (t0 + 1368U);
    t5 = *((char **)t3);
    t3 = (t0 + 2248);
    t12 = (t3 + 56U);
    t13 = *((char **)t12);
    memset(t37, 0, 8);
    if (*((unsigned int *)t5) != *((unsigned int *)t13))
        goto LAB155;

LAB153:    t17 = (t5 + 4);
    t18 = (t13 + 4);
    if (*((unsigned int *)t17) != *((unsigned int *)t18))
        goto LAB155;

LAB154:    *((unsigned int *)t37) = 1;

LAB155:    memset(t21, 0, 8);
    t19 = (t37 + 4);
    t7 = *((unsigned int *)t19);
    t8 = (~(t7));
    t9 = *((unsigned int *)t37);
    t10 = (t9 & t8);
    t11 = (t10 & 1U);
    if (t11 != 0)
        goto LAB156;

LAB157:    if (*((unsigned int *)t19) != 0)
        goto LAB158;

LAB159:    t22 = (t21 + 4);
    t14 = *((unsigned int *)t21);
    t15 = *((unsigned int *)t22);
    t16 = (t14 || t15);
    if (t16 > 0)
        goto LAB160;

LAB161:    t24 = *((unsigned int *)t21);
    t25 = (~(t24));
    t26 = *((unsigned int *)t22);
    t27 = (t25 || t26);
    if (t27 > 0)
        goto LAB162;

LAB163:    if (*((unsigned int *)t22) > 0)
        goto LAB164;

LAB165:    if (*((unsigned int *)t21) > 0)
        goto LAB166;

LAB167:    memcpy(t6, t36, 8);

LAB168:    t38 = (t0 + 1928);
    xsi_vlogvar_wait_assign_value(t38, t6, 0, 0, 3, 0LL);
    goto LAB56;

LAB60:    *((unsigned int *)t21) = 1;
    goto LAB63;

LAB62:    t23 = (t21 + 4);
    *((unsigned int *)t21) = 1;
    *((unsigned int *)t23) = 1;
    goto LAB63;

LAB64:    t38 = ((char*)((ng2)));
    goto LAB65;

LAB66:    t44 = ((char*)((ng3)));
    goto LAB67;

LAB68:    xsi_vlog_unsigned_bit_combine(t6, 32, t38, 32, t44, 32);
    goto LAB72;

LAB70:    memcpy(t6, t38, 8);
    goto LAB72;

LAB76:    *((unsigned int *)t21) = 1;
    goto LAB79;

LAB78:    t20 = (t21 + 4);
    *((unsigned int *)t21) = 1;
    *((unsigned int *)t20) = 1;
    goto LAB79;

LAB80:    t23 = ((char*)((ng1)));
    goto LAB81;

LAB82:    t36 = ((char*)((ng4)));
    goto LAB83;

LAB84:    xsi_vlog_unsigned_bit_combine(t6, 32, t23, 32, t36, 32);
    goto LAB88;

LAB86:    memcpy(t6, t23, 8);
    goto LAB88;

LAB92:    *((unsigned int *)t21) = 1;
    goto LAB95;

LAB94:    t20 = (t21 + 4);
    *((unsigned int *)t21) = 1;
    *((unsigned int *)t20) = 1;
    goto LAB95;

LAB96:    t23 = ((char*)((ng5)));
    goto LAB97;

LAB98:    t36 = ((char*)((ng6)));
    goto LAB99;

LAB100:    xsi_vlog_unsigned_bit_combine(t6, 32, t23, 32, t36, 32);
    goto LAB104;

LAB102:    memcpy(t6, t23, 8);
    goto LAB104;

LAB108:    *((unsigned int *)t21) = 1;
    goto LAB111;

LAB110:    t20 = (t21 + 4);
    *((unsigned int *)t21) = 1;
    *((unsigned int *)t20) = 1;
    goto LAB111;

LAB112:    t23 = ((char*)((ng7)));
    goto LAB113;

LAB114:    t36 = ((char*)((ng3)));
    goto LAB115;

LAB116:    xsi_vlog_unsigned_bit_combine(t6, 32, t23, 32, t36, 32);
    goto LAB120;

LAB118:    memcpy(t6, t23, 8);
    goto LAB120;

LAB124:    *((unsigned int *)t21) = 1;
    goto LAB127;

LAB126:    t20 = (t21 + 4);
    *((unsigned int *)t21) = 1;
    *((unsigned int *)t20) = 1;
    goto LAB127;

LAB128:    t23 = ((char*)((ng7)));
    goto LAB129;

LAB130:    t36 = ((char*)((ng2)));
    goto LAB131;

LAB132:    xsi_vlog_unsigned_bit_combine(t6, 32, t23, 32, t36, 32);
    goto LAB136;

LAB134:    memcpy(t6, t23, 8);
    goto LAB136;

LAB140:    *((unsigned int *)t21) = 1;
    goto LAB143;

LAB142:    t20 = (t21 + 4);
    *((unsigned int *)t21) = 1;
    *((unsigned int *)t20) = 1;
    goto LAB143;

LAB144:    t23 = ((char*)((ng8)));
    goto LAB145;

LAB146:    t36 = ((char*)((ng3)));
    goto LAB147;

LAB148:    xsi_vlog_unsigned_bit_combine(t6, 32, t23, 32, t36, 32);
    goto LAB152;

LAB150:    memcpy(t6, t23, 8);
    goto LAB152;

LAB156:    *((unsigned int *)t21) = 1;
    goto LAB159;

LAB158:    t20 = (t21 + 4);
    *((unsigned int *)t21) = 1;
    *((unsigned int *)t20) = 1;
    goto LAB159;

LAB160:    t23 = ((char*)((ng7)));
    goto LAB161;

LAB162:    t36 = ((char*)((ng5)));
    goto LAB163;

LAB164:    xsi_vlog_unsigned_bit_combine(t6, 32, t23, 32, t36, 32);
    goto LAB168;

LAB166:    memcpy(t6, t23, 8);
    goto LAB168;

}

static void Always_54_1(char *t0)
{
    char t8[8];
    char t34[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t9;
    char *t10;
    unsigned int t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    char *t23;
    char *t24;
    unsigned int t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    unsigned int t29;
    char *t30;
    char *t31;
    char *t32;
    char *t33;
    char *t35;

LAB0:    t1 = (t0 + 3408U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(54, ng0);
    t2 = (t0 + 3992);
    *((int *)t2) = 1;
    t3 = (t0 + 3440);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(54, ng0);

LAB5:    xsi_set_current_line(55, ng0);
    t4 = (t0 + 2088);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng1)));
    memset(t8, 0, 8);
    t9 = (t6 + 4);
    t10 = (t7 + 4);
    t11 = *((unsigned int *)t6);
    t12 = *((unsigned int *)t7);
    t13 = (t11 ^ t12);
    t14 = *((unsigned int *)t9);
    t15 = *((unsigned int *)t10);
    t16 = (t14 ^ t15);
    t17 = (t13 | t16);
    t18 = *((unsigned int *)t9);
    t19 = *((unsigned int *)t10);
    t20 = (t18 | t19);
    t21 = (~(t20));
    t22 = (t17 & t21);
    if (t22 != 0)
        goto LAB9;

LAB6:    if (t20 != 0)
        goto LAB8;

LAB7:    *((unsigned int *)t8) = 1;

LAB9:    t24 = (t8 + 4);
    t25 = *((unsigned int *)t24);
    t26 = (~(t25));
    t27 = *((unsigned int *)t8);
    t28 = (t27 & t26);
    t29 = (t28 != 0);
    if (t29 > 0)
        goto LAB10;

LAB11:
LAB12:    goto LAB2;

LAB8:    t23 = (t8 + 4);
    *((unsigned int *)t8) = 1;
    *((unsigned int *)t23) = 1;
    goto LAB9;

LAB10:    xsi_set_current_line(55, ng0);
    t30 = (t0 + 2088);
    t31 = (t30 + 56U);
    t32 = *((char **)t31);
    t33 = ((char*)((ng2)));
    memset(t34, 0, 8);
    xsi_vlog_unsigned_add(t34, 32, t32, 1, t33, 32);
    t35 = (t0 + 2088);
    xsi_vlogvar_wait_assign_value(t35, t34, 0, 0, 1, 0LL);
    goto LAB12;

}

static void Cont_59_2(char *t0)
{
    char t6[8];
    char t22[8];
    char t39[8];
    char t55[8];
    char t63[8];
    char t91[8];
    char t108[8];
    char t124[8];
    char t132[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t7;
    char *t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    char *t21;
    char *t23;
    unsigned int t24;
    unsigned int t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    char *t29;
    char *t30;
    unsigned int t31;
    unsigned int t32;
    unsigned int t33;
    unsigned int t34;
    char *t35;
    char *t36;
    char *t37;
    char *t38;
    char *t40;
    char *t41;
    unsigned int t42;
    unsigned int t43;
    unsigned int t44;
    unsigned int t45;
    unsigned int t46;
    unsigned int t47;
    unsigned int t48;
    unsigned int t49;
    unsigned int t50;
    unsigned int t51;
    unsigned int t52;
    unsigned int t53;
    char *t54;
    char *t56;
    unsigned int t57;
    unsigned int t58;
    unsigned int t59;
    unsigned int t60;
    unsigned int t61;
    char *t62;
    unsigned int t64;
    unsigned int t65;
    unsigned int t66;
    char *t67;
    char *t68;
    char *t69;
    unsigned int t70;
    unsigned int t71;
    unsigned int t72;
    unsigned int t73;
    unsigned int t74;
    unsigned int t75;
    unsigned int t76;
    char *t77;
    char *t78;
    unsigned int t79;
    unsigned int t80;
    unsigned int t81;
    int t82;
    unsigned int t83;
    unsigned int t84;
    unsigned int t85;
    int t86;
    unsigned int t87;
    unsigned int t88;
    unsigned int t89;
    unsigned int t90;
    char *t92;
    unsigned int t93;
    unsigned int t94;
    unsigned int t95;
    unsigned int t96;
    unsigned int t97;
    char *t98;
    char *t99;
    unsigned int t100;
    unsigned int t101;
    unsigned int t102;
    unsigned int t103;
    char *t104;
    char *t105;
    char *t106;
    char *t107;
    char *t109;
    char *t110;
    unsigned int t111;
    unsigned int t112;
    unsigned int t113;
    unsigned int t114;
    unsigned int t115;
    unsigned int t116;
    unsigned int t117;
    unsigned int t118;
    unsigned int t119;
    unsigned int t120;
    unsigned int t121;
    unsigned int t122;
    char *t123;
    char *t125;
    unsigned int t126;
    unsigned int t127;
    unsigned int t128;
    unsigned int t129;
    unsigned int t130;
    char *t131;
    unsigned int t133;
    unsigned int t134;
    unsigned int t135;
    char *t136;
    char *t137;
    char *t138;
    unsigned int t139;
    unsigned int t140;
    unsigned int t141;
    unsigned int t142;
    unsigned int t143;
    unsigned int t144;
    unsigned int t145;
    char *t146;
    char *t147;
    unsigned int t148;
    unsigned int t149;
    unsigned int t150;
    int t151;
    unsigned int t152;
    unsigned int t153;
    unsigned int t154;
    int t155;
    unsigned int t156;
    unsigned int t157;
    unsigned int t158;
    unsigned int t159;
    char *t160;
    char *t161;
    char *t162;
    char *t163;
    char *t164;
    unsigned int t165;
    unsigned int t166;
    char *t167;
    unsigned int t168;
    unsigned int t169;
    char *t170;
    unsigned int t171;
    unsigned int t172;
    char *t173;

LAB0:    t1 = (t0 + 3656U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(59, ng0);
    t2 = (t0 + 1928);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng6)));
    memset(t6, 0, 8);
    t7 = (t4 + 4);
    t8 = (t5 + 4);
    t9 = *((unsigned int *)t4);
    t10 = *((unsigned int *)t5);
    t11 = (t9 ^ t10);
    t12 = *((unsigned int *)t7);
    t13 = *((unsigned int *)t8);
    t14 = (t12 ^ t13);
    t15 = (t11 | t14);
    t16 = *((unsigned int *)t7);
    t17 = *((unsigned int *)t8);
    t18 = (t16 | t17);
    t19 = (~(t18));
    t20 = (t15 & t19);
    if (t20 != 0)
        goto LAB7;

LAB4:    if (t18 != 0)
        goto LAB6;

LAB5:    *((unsigned int *)t6) = 1;

LAB7:    memset(t22, 0, 8);
    t23 = (t6 + 4);
    t24 = *((unsigned int *)t23);
    t25 = (~(t24));
    t26 = *((unsigned int *)t6);
    t27 = (t26 & t25);
    t28 = (t27 & 1U);
    if (t28 != 0)
        goto LAB8;

LAB9:    if (*((unsigned int *)t23) != 0)
        goto LAB10;

LAB11:    t30 = (t22 + 4);
    t31 = *((unsigned int *)t22);
    t32 = (!(t31));
    t33 = *((unsigned int *)t30);
    t34 = (t32 || t33);
    if (t34 > 0)
        goto LAB12;

LAB13:    memcpy(t63, t22, 8);

LAB14:    memset(t91, 0, 8);
    t92 = (t63 + 4);
    t93 = *((unsigned int *)t92);
    t94 = (~(t93));
    t95 = *((unsigned int *)t63);
    t96 = (t95 & t94);
    t97 = (t96 & 1U);
    if (t97 != 0)
        goto LAB26;

LAB27:    if (*((unsigned int *)t92) != 0)
        goto LAB28;

LAB29:    t99 = (t91 + 4);
    t100 = *((unsigned int *)t91);
    t101 = (!(t100));
    t102 = *((unsigned int *)t99);
    t103 = (t101 || t102);
    if (t103 > 0)
        goto LAB30;

LAB31:    memcpy(t132, t91, 8);

LAB32:    t160 = (t0 + 4088);
    t161 = (t160 + 56U);
    t162 = *((char **)t161);
    t163 = (t162 + 56U);
    t164 = *((char **)t163);
    memset(t164, 0, 8);
    t165 = 1U;
    t166 = t165;
    t167 = (t132 + 4);
    t168 = *((unsigned int *)t132);
    t165 = (t165 & t168);
    t169 = *((unsigned int *)t167);
    t166 = (t166 & t169);
    t170 = (t164 + 4);
    t171 = *((unsigned int *)t164);
    *((unsigned int *)t164) = (t171 | t165);
    t172 = *((unsigned int *)t170);
    *((unsigned int *)t170) = (t172 | t166);
    xsi_driver_vfirst_trans(t160, 0, 0);
    t173 = (t0 + 4008);
    *((int *)t173) = 1;

LAB1:    return;
LAB6:    t21 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t21) = 1;
    goto LAB7;

LAB8:    *((unsigned int *)t22) = 1;
    goto LAB11;

LAB10:    t29 = (t22 + 4);
    *((unsigned int *)t22) = 1;
    *((unsigned int *)t29) = 1;
    goto LAB11;

LAB12:    t35 = (t0 + 1928);
    t36 = (t35 + 56U);
    t37 = *((char **)t36);
    t38 = ((char*)((ng4)));
    memset(t39, 0, 8);
    t40 = (t37 + 4);
    t41 = (t38 + 4);
    t42 = *((unsigned int *)t37);
    t43 = *((unsigned int *)t38);
    t44 = (t42 ^ t43);
    t45 = *((unsigned int *)t40);
    t46 = *((unsigned int *)t41);
    t47 = (t45 ^ t46);
    t48 = (t44 | t47);
    t49 = *((unsigned int *)t40);
    t50 = *((unsigned int *)t41);
    t51 = (t49 | t50);
    t52 = (~(t51));
    t53 = (t48 & t52);
    if (t53 != 0)
        goto LAB18;

LAB15:    if (t51 != 0)
        goto LAB17;

LAB16:    *((unsigned int *)t39) = 1;

LAB18:    memset(t55, 0, 8);
    t56 = (t39 + 4);
    t57 = *((unsigned int *)t56);
    t58 = (~(t57));
    t59 = *((unsigned int *)t39);
    t60 = (t59 & t58);
    t61 = (t60 & 1U);
    if (t61 != 0)
        goto LAB19;

LAB20:    if (*((unsigned int *)t56) != 0)
        goto LAB21;

LAB22:    t64 = *((unsigned int *)t22);
    t65 = *((unsigned int *)t55);
    t66 = (t64 | t65);
    *((unsigned int *)t63) = t66;
    t67 = (t22 + 4);
    t68 = (t55 + 4);
    t69 = (t63 + 4);
    t70 = *((unsigned int *)t67);
    t71 = *((unsigned int *)t68);
    t72 = (t70 | t71);
    *((unsigned int *)t69) = t72;
    t73 = *((unsigned int *)t69);
    t74 = (t73 != 0);
    if (t74 == 1)
        goto LAB23;

LAB24:
LAB25:    goto LAB14;

LAB17:    t54 = (t39 + 4);
    *((unsigned int *)t39) = 1;
    *((unsigned int *)t54) = 1;
    goto LAB18;

LAB19:    *((unsigned int *)t55) = 1;
    goto LAB22;

LAB21:    t62 = (t55 + 4);
    *((unsigned int *)t55) = 1;
    *((unsigned int *)t62) = 1;
    goto LAB22;

LAB23:    t75 = *((unsigned int *)t63);
    t76 = *((unsigned int *)t69);
    *((unsigned int *)t63) = (t75 | t76);
    t77 = (t22 + 4);
    t78 = (t55 + 4);
    t79 = *((unsigned int *)t77);
    t80 = (~(t79));
    t81 = *((unsigned int *)t22);
    t82 = (t81 & t80);
    t83 = *((unsigned int *)t78);
    t84 = (~(t83));
    t85 = *((unsigned int *)t55);
    t86 = (t85 & t84);
    t87 = (~(t82));
    t88 = (~(t86));
    t89 = *((unsigned int *)t69);
    *((unsigned int *)t69) = (t89 & t87);
    t90 = *((unsigned int *)t69);
    *((unsigned int *)t69) = (t90 & t88);
    goto LAB25;

LAB26:    *((unsigned int *)t91) = 1;
    goto LAB29;

LAB28:    t98 = (t91 + 4);
    *((unsigned int *)t91) = 1;
    *((unsigned int *)t98) = 1;
    goto LAB29;

LAB30:    t104 = (t0 + 1928);
    t105 = (t104 + 56U);
    t106 = *((char **)t105);
    t107 = ((char*)((ng7)));
    memset(t108, 0, 8);
    t109 = (t106 + 4);
    t110 = (t107 + 4);
    t111 = *((unsigned int *)t106);
    t112 = *((unsigned int *)t107);
    t113 = (t111 ^ t112);
    t114 = *((unsigned int *)t109);
    t115 = *((unsigned int *)t110);
    t116 = (t114 ^ t115);
    t117 = (t113 | t116);
    t118 = *((unsigned int *)t109);
    t119 = *((unsigned int *)t110);
    t120 = (t118 | t119);
    t121 = (~(t120));
    t122 = (t117 & t121);
    if (t122 != 0)
        goto LAB36;

LAB33:    if (t120 != 0)
        goto LAB35;

LAB34:    *((unsigned int *)t108) = 1;

LAB36:    memset(t124, 0, 8);
    t125 = (t108 + 4);
    t126 = *((unsigned int *)t125);
    t127 = (~(t126));
    t128 = *((unsigned int *)t108);
    t129 = (t128 & t127);
    t130 = (t129 & 1U);
    if (t130 != 0)
        goto LAB37;

LAB38:    if (*((unsigned int *)t125) != 0)
        goto LAB39;

LAB40:    t133 = *((unsigned int *)t91);
    t134 = *((unsigned int *)t124);
    t135 = (t133 | t134);
    *((unsigned int *)t132) = t135;
    t136 = (t91 + 4);
    t137 = (t124 + 4);
    t138 = (t132 + 4);
    t139 = *((unsigned int *)t136);
    t140 = *((unsigned int *)t137);
    t141 = (t139 | t140);
    *((unsigned int *)t138) = t141;
    t142 = *((unsigned int *)t138);
    t143 = (t142 != 0);
    if (t143 == 1)
        goto LAB41;

LAB42:
LAB43:    goto LAB32;

LAB35:    t123 = (t108 + 4);
    *((unsigned int *)t108) = 1;
    *((unsigned int *)t123) = 1;
    goto LAB36;

LAB37:    *((unsigned int *)t124) = 1;
    goto LAB40;

LAB39:    t131 = (t124 + 4);
    *((unsigned int *)t124) = 1;
    *((unsigned int *)t131) = 1;
    goto LAB40;

LAB41:    t144 = *((unsigned int *)t132);
    t145 = *((unsigned int *)t138);
    *((unsigned int *)t132) = (t144 | t145);
    t146 = (t91 + 4);
    t147 = (t124 + 4);
    t148 = *((unsigned int *)t146);
    t149 = (~(t148));
    t150 = *((unsigned int *)t91);
    t151 = (t150 & t149);
    t152 = *((unsigned int *)t147);
    t153 = (~(t152));
    t154 = *((unsigned int *)t124);
    t155 = (t154 & t153);
    t156 = (~(t151));
    t157 = (~(t155));
    t158 = *((unsigned int *)t138);
    *((unsigned int *)t138) = (t158 & t156);
    t159 = *((unsigned int *)t138);
    *((unsigned int *)t138) = (t159 & t157);
    goto LAB43;

}


extern void work_m_05232606695245157265_1200899892_init()
{
	static char *pe[] = {(void *)Always_32_0,(void *)Always_54_1,(void *)Cont_59_2};
	xsi_register_didat("work_m_05232606695245157265_1200899892", "isim/alternate_tb_isim_beh.exe.sim/work/m_05232606695245157265_1200899892.didat");
	xsi_register_executes(pe);
}
