#include <stdio.h>
#include <stdlib.h>
#include <strings.h>
#include "rmapats.h"

scalar dummyScalar;
scalar fScalarIsForced=0;
scalar fScalarIsReleased=0;
scalar fScalarHasChanged=0;
scalar fForceFromNonRoot=0;
scalar fNettypeIsForced=0;
scalar fNettypeIsReleased=0;
void  hsG_0 (struct dummyq_struct * I1005, EBLK  * I1006, U  I711);
void  hsG_0 (struct dummyq_struct * I1005, EBLK  * I1006, U  I711)
{
    U  I1235;
    U  I1236;
    U  I1237;
    struct futq * I1238;
    I1235 = ((U )vcs_clocks) + I711;
    I1237 = I1235 & 0xfff;
    I1006->I644 = (EBLK  *)(-1);
    I1006->I648 = I1235;
    if (I1235 < (U )vcs_clocks) {
        I1236 = ((U  *)&vcs_clocks)[1];
        sched_millenium(I1005, I1006, I1236 + 1, I1235);
    }
    else if ((peblkFutQ1Head != ((void *)0)) && (I711 == 1)) {
        I1006->I649 = (struct eblk *)peblkFutQ1Tail;
        peblkFutQ1Tail->I644 = I1006;
        peblkFutQ1Tail = I1006;
    }
    else if ((I1238 = I1005->I971[I1237].I661)) {
        I1006->I649 = (struct eblk *)I1238->I660;
        I1238->I660->I644 = (RP )I1006;
        I1238->I660 = (RmaEblk  *)I1006;
    }
    else {
        sched_hsopt(I1005, I1006, I1235);
    }
}
#ifdef __cplusplus
extern "C" {
#endif
void SinitHsimPats(void);
#ifdef __cplusplus
}
#endif
