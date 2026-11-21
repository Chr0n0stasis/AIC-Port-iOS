#include <mach/mach.h>
#include <stdbool.h>
#include <stdint.h>

extern bool criAtomUnity_IsInitialized(void);
extern bool criFsUnity_IsInitialized(void);
extern uint32_t criAtomUnity_GetAllocatedHeapSize(void);
extern uint32_t criFsUnity_GetAllocatedHeapSize(void);

typedef struct {
    int64_t footprint;
    int64_t graphics;
    int64_t media;
    int64_t device;
    int64_t internalResident;
    int64_t compressed;
    int64_t criAtom;
    int64_t criFs;
} AICMemoryLedger;

int AICReadMemoryLedger(AICMemoryLedger *snapshot)
{
    task_vm_info_data_t info = {0};
    mach_msg_type_number_t count = TASK_VM_INFO_REV3_COUNT;
    kern_return_t result = task_info(mach_task_self(), TASK_VM_INFO, (task_info_t)&info, &count);
    if (result != KERN_SUCCESS || count < TASK_VM_INFO_REV3_COUNT) {
        return 0;
    }

    snapshot->footprint = (int64_t)info.phys_footprint;
    snapshot->graphics = info.ledger_tag_graphics_footprint + info.ledger_tag_graphics_footprint_compressed;
    snapshot->media = info.ledger_tag_media_footprint + info.ledger_tag_media_footprint_compressed;
    snapshot->device = (int64_t)info.device;
    snapshot->internalResident = (int64_t)info.internal;
    snapshot->compressed = (int64_t)info.compressed;
    snapshot->criAtom = criAtomUnity_IsInitialized() ? criAtomUnity_GetAllocatedHeapSize() : 0;
    snapshot->criFs = criFsUnity_IsInitialized() ? criFsUnity_GetAllocatedHeapSize() : 0;
    return 1;
}
