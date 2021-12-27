/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/

#if defined(_WIN32)
 #include "stdio.h"
#endif
#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/

#if defined(_WIN32)
 #include "stdio.h"
#endif
#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
typedef void (*funcp)(char *, char *);
extern int main(int, char**);
extern void execute_902(char*, char *);
extern void execute_903(char*, char *);
extern void execute_16(char*, char *);
extern void execute_17(char*, char *);
extern void execute_18(char*, char *);
extern void execute_19(char*, char *);
extern void execute_20(char*, char *);
extern void execute_21(char*, char *);
extern void execute_22(char*, char *);
extern void execute_23(char*, char *);
extern void execute_151(char*, char *);
extern void execute_159(char*, char *);
extern void execute_219(char*, char *);
extern void execute_220(char*, char *);
extern void execute_875(char*, char *);
extern void execute_876(char*, char *);
extern void execute_25(char*, char *);
extern void execute_26(char*, char *);
extern void execute_31(char*, char *);
extern void execute_32(char*, char *);
extern void execute_36(char*, char *);
extern void execute_37(char*, char *);
extern void execute_89(char*, char *);
extern void execute_90(char*, char *);
extern void execute_91(char*, char *);
extern void execute_150(char*, char *);
extern void execute_153(char*, char *);
extern void execute_154(char*, char *);
extern void execute_156(char*, char *);
extern void execute_161(char*, char *);
extern void execute_162(char*, char *);
extern void execute_216(char*, char *);
extern void execute_222(char*, char *);
extern void execute_223(char*, char *);
extern void execute_224(char*, char *);
extern void execute_226(char*, char *);
extern void execute_227(char*, char *);
extern void execute_229(char*, char *);
extern void execute_230(char*, char *);
extern void execute_231(char*, char *);
extern void execute_386(char*, char *);
extern void execute_233(char*, char *);
extern void execute_234(char*, char *);
extern void execute_547(char*, char *);
extern void execute_548(char*, char *);
extern void execute_707(char*, char *);
extern void execute_708(char*, char *);
extern void execute_709(char*, char *);
extern void execute_870(char*, char *);
extern void execute_900(char*, char *);
extern void execute_901(char*, char *);
extern void transaction_0(char*, char*, unsigned, unsigned, unsigned);
extern void vhdl_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
funcp funcTab[53] = {(funcp)execute_902, (funcp)execute_903, (funcp)execute_16, (funcp)execute_17, (funcp)execute_18, (funcp)execute_19, (funcp)execute_20, (funcp)execute_21, (funcp)execute_22, (funcp)execute_23, (funcp)execute_151, (funcp)execute_159, (funcp)execute_219, (funcp)execute_220, (funcp)execute_875, (funcp)execute_876, (funcp)execute_25, (funcp)execute_26, (funcp)execute_31, (funcp)execute_32, (funcp)execute_36, (funcp)execute_37, (funcp)execute_89, (funcp)execute_90, (funcp)execute_91, (funcp)execute_150, (funcp)execute_153, (funcp)execute_154, (funcp)execute_156, (funcp)execute_161, (funcp)execute_162, (funcp)execute_216, (funcp)execute_222, (funcp)execute_223, (funcp)execute_224, (funcp)execute_226, (funcp)execute_227, (funcp)execute_229, (funcp)execute_230, (funcp)execute_231, (funcp)execute_386, (funcp)execute_233, (funcp)execute_234, (funcp)execute_547, (funcp)execute_548, (funcp)execute_707, (funcp)execute_708, (funcp)execute_709, (funcp)execute_870, (funcp)execute_900, (funcp)execute_901, (funcp)transaction_0, (funcp)vhdl_transfunc_eventcallback};
const int NumRelocateId= 53;

void relocate(char *dp)
{
	iki_relocate(dp, "xsim.dir/FloatAdder_TB_behav/xsim.reloc",  (void **)funcTab, 53);
	iki_vhdl_file_variable_register(dp + 37016);
	iki_vhdl_file_variable_register(dp + 37072);


	/*Populate the transaction function pointer field in the whole net structure */
}

void sensitize(char *dp)
{
	iki_sensitize(dp, "xsim.dir/FloatAdder_TB_behav/xsim.reloc");
}

void simulate(char *dp)
{
		iki_schedule_processes_at_time_zero(dp, "xsim.dir/FloatAdder_TB_behav/xsim.reloc");
	// Initialize Verilog nets in mixed simulation, for the cases when the value at time 0 should be propagated from the mixed language Vhdl net
	iki_execute_processes();

	// Schedule resolution functions for the multiply driven Verilog nets that have strength
	// Schedule transaction functions for the singly driven Verilog nets that have strength

}
#include "iki_bridge.h"
void relocate(char *);

void sensitize(char *);

void simulate(char *);

extern SYSTEMCLIB_IMP_DLLSPEC void local_register_implicit_channel(int, char*);
extern void implicit_HDL_SCinstantiate();

extern void implicit_HDL_SCcleanup();

extern SYSTEMCLIB_IMP_DLLSPEC int xsim_argc_copy ;
extern SYSTEMCLIB_IMP_DLLSPEC char** xsim_argv_copy ;

int main(int argc, char **argv)
{
    iki_heap_initialize("ms", "isimmm", 0, 2147483648) ;
    iki_set_sv_type_file_path_name("xsim.dir/FloatAdder_TB_behav/xsim.svtype");
    iki_set_crvs_dump_file_path_name("xsim.dir/FloatAdder_TB_behav/xsim.crvsdump");
    void* design_handle = iki_create_design("xsim.dir/FloatAdder_TB_behav/xsim.mem", (void *)relocate, (void *)sensitize, (void *)simulate, 0, isimBridge_getWdbWriter(), 0, argc, argv);
     iki_set_rc_trial_count(100);
    (void) design_handle;
    return iki_simulate_design();
}
