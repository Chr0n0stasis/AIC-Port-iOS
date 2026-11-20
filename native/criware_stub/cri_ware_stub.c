// Auto-generated dummy stub for cri_ware_unity (iOS fallback)
#include <stdint.h>
#include <stdbool.h>
#include <stddef.h>

#define EXPORT __attribute__((visibility("default")))

// The muted fallback has no CRI errors to forward to the managed callback.
EXPORT void criErr_SetCallback(void *callback) { (void)callback; }
EXPORT void aic_criErr_SetCallbackPointer(intptr_t callback) { (void)callback; }

EXPORT void criFsUnity_SetConfigParameters() { }
EXPORT void criFsUnity_Initialize() { }
EXPORT bool criFsUnity_IsInitialized() { return true; }
EXPORT void criFsUnity_Finalize() { }
EXPORT int32_t criFsUnity_GetAllocatedHeapSize() { return 0; }
EXPORT bool criAtomUnityThumbnail_LoadWaveform() { return true; }
EXPORT void criAtomUnity_SetConfigParameters() { }
EXPORT void criAtomUnity_SetConfigMonitorParameters() { }
EXPORT void criAtomUnity_SetConfigAdditionalParameters_EDITOR() { }
EXPORT void criAtomUnity_SetConfigAdditionalParameters_PC() { }
EXPORT void criAtomUnity_SetConfigAdditionalParameters_IOS() { }
EXPORT void criAtomUnity_SetConfigAdditionalParameters_ANDROID() { }
EXPORT void criAtomUnity_Initialize() { }
EXPORT bool criAtomUnity_IsInitialized() { return true; }
EXPORT void criAtomUnity_Finalize() { }
EXPORT void criAtomUnity_Pause() { }
EXPORT int32_t criAtomUnity_GetAllocatedHeapSize() { return 0; }
EXPORT void criAtomUnity_ControlDataCompatibility() { }
EXPORT void criAtomUnitySequencer_SetEventCallback() { }
EXPORT void criAtomUnitySequencer_SetCallback() { }
EXPORT void criAtomUnitySequencer_ExecuteQueuedEventCallbacks() { }
EXPORT void criAtomUnity_SetBeatSyncCallback() { }
EXPORT void criAtomUnity_ExecuteQueuedBeatSyncCallbacks() { }
EXPORT void criAtomUnity_SetCueLinkCallback() { }
EXPORT void criAtomUnity_ExecuteQueuedCueLinkCallbacks() { }
EXPORT void criAtomUnity_SetMaxSamplingRateForStandardVoicePool() { }
EXPORT void criAtomUnity_BeginLeCompatibleMode() { }
EXPORT void criAtomUnity_EndLeCompatibleMode() { }
EXPORT void criAtomUnity_GetNativeParameterId() { }
EXPORT bool criAtomUnity_IsInitializedForPcmOutput_EDITOR() { return true; }
EXPORT int32_t criAtomUnity_GetAsrOutputSamplingRate() { return 0; }
EXPORT int32_t criAtomUnity_GetAsrOutputChannels() { return 0; }
EXPORT bool criAtomEx_RegisterAcfFile() { return true; }
EXPORT bool criAtomEx_RegisterAcfData() { return true; }
EXPORT void criAtomEx_UnregisterAcf() { }
EXPORT void criAtomEx_AttachDspBusSetting() { }
EXPORT void criAtomEx_DetachDspBusSetting() { }
EXPORT void criAtomEx_ApplyDspBusSnapshot() { }
EXPORT void* criAtomEx_GetAppliedDspBusSnapshotName() { return NULL; }
EXPORT int32_t criAtomEx_GetNumGameVariables() { return 0; }
EXPORT bool criAtomEx_GetGameVariableInfo() { return true; }
EXPORT float criAtomEx_GetGameVariableById() { return 0.0f; }
EXPORT float criAtomEx_GetGameVariableByName() { return 0.0f; }
EXPORT void criAtomEx_SetGameVariableById() { }
EXPORT void criAtomEx_SetGameVariableByName() { }
EXPORT void criAtomEx_SetRandomSeed() { }
EXPORT void criAtomEx_PauseTimer() { }
EXPORT void criAtomEx_Lock() { }
EXPORT void criAtomEx_Unlock() { }
EXPORT void criAtom_ResetPerformanceMonitor() { }
EXPORT void criAtom_GetPerformanceInfo() { }
EXPORT void criAtomExAcf_SetGlobalLabelToSelectorByIndex() { }
EXPORT void criAtomExAcf_SetGlobalLabelToSelectorByName() { }
EXPORT void criAtomEx_SetSpeakerAngleArray() { }
EXPORT void criAtomEx_SetVirtualSpeakerAngleArray() { }
EXPORT void criAtomEx_ControlVirtualSpeakerSetting() { }
EXPORT void criAtomEx_EnableBusSendOffsetWhenLevelNotExist() { }
EXPORT void criAtomExCategory_SetVolumeByName() { }
EXPORT float criAtomExCategory_GetVolumeByName() { return 0.0f; }
EXPORT void criAtomExCategory_SetVolumeById() { }
EXPORT float criAtomExCategory_GetVolumeById() { return 0.0f; }
EXPORT void criAtomExCategory_MuteById() { }
EXPORT bool criAtomExCategory_IsMutedById() { return true; }
EXPORT void criAtomExCategory_MuteByName() { }
EXPORT bool criAtomExCategory_IsMutedByName() { return true; }
EXPORT void criAtomExCategory_SoloById() { }
EXPORT bool criAtomExCategory_IsSoloedById() { return true; }
EXPORT void criAtomExCategory_SoloByName() { }
EXPORT bool criAtomExCategory_IsSoloedByName() { return true; }
EXPORT void criAtomExCategory_PauseById() { }
EXPORT bool criAtomExCategory_IsPausedById() { return true; }
EXPORT void criAtomExCategory_PauseByName() { }
EXPORT bool criAtomExCategory_IsPausedByName() { return true; }
EXPORT void criAtomExCategory_SetAisacControlById() { }
EXPORT void criAtomExCategory_SetAisacControlByName() { }
EXPORT void criAtomExCategory_SetReactParameter() { }
EXPORT bool criAtomExCategory_GetReactParameter() { return true; }
EXPORT bool criAtomExCategory_GetAttachedAisacInfoById() { return true; }
EXPORT bool criAtomExCategory_GetAttachedAisacInfoByName() { return true; }
EXPORT bool criAtomExCategory_GetCurrentAisacControlValueByName() { return true; }
EXPORT void criAtomExCategory_GetReactStatus() { }
EXPORT float criAtomExCategory_GetTotalVolumeById() { return 0.0f; }
EXPORT float criAtomExCategory_GetTotalVolumeByName() { return 0.0f; }
EXPORT void criAtomExCategory_SetFadeInTimeById() { }
EXPORT void criAtomExCategory_SetFadeInTimeByName() { }
EXPORT void criAtomExCategory_SetFadeOutTimeById() { }
EXPORT void criAtomExCategory_SetFadeOutTimeByName() { }
EXPORT bool criAtomExCategory_ResetAllAisacControlById() { return true; }
EXPORT bool criAtomExCategory_ResetAllAisacControlByName() { return true; }
EXPORT void criAtomExCategory_AttachAisacById() { }
EXPORT void criAtomExCategory_AttachAisacByName() { }
EXPORT void criAtomExCategory_DetachAisacById() { }
EXPORT void criAtomExCategory_DetachAisacByName() { }
EXPORT void criAtomExCategory_DetachAisacAllById() { }
EXPORT void criAtomExCategory_DetachAisacAllByName() { }
EXPORT int32_t criAtomExCategory_GetNumAttachedAisacsById() { return 0; }
EXPORT int32_t criAtomExCategory_GetNumAttachedAisacsByName() { return 0; }
EXPORT int32_t criAtomExCategory_GetNumCuePlayingCountById() { return 0; }
EXPORT int32_t criAtomExCategory_GetNumCuePlayingCountByName() { return 0; }
EXPORT void criAtomExCategory_StopById() { }
EXPORT void criAtomExCategory_StopByName() { }
EXPORT void criAtomExCategory_StopWithoutReleaseTimeById() { }
EXPORT void criAtomExCategory_StopWithoutReleaseTimeByName() { }
EXPORT void criAtomExAsr_AttachBusAnalyzerByName() { }
EXPORT void criAtomExAsr_AttachBusAnalyzer() { }
EXPORT void criAtomExAsr_DetachBusAnalyzerByName() { }
EXPORT void criAtomExAsr_DetachBusAnalyzer() { }
EXPORT void criAtomExAsr_GetBusAnalyzerInfoByName() { }
EXPORT void criAtomExAsr_GetBusAnalyzerInfo() { }
EXPORT void criAtomExAsr_SetBusVolumeByName() { }
EXPORT void criAtomExAsr_SetBusVolume() { }
EXPORT void criAtomExAsr_SetBusSendLevelByName() { }
EXPORT void criAtomExAsr_SetBusSendLevel() { }
EXPORT void criAtomExAsr_SetBusMatrixByName() { }
EXPORT void criAtomExAsr_SetBusMatrix() { }
EXPORT void criAtomExAsr_SetEffectBypass() { }
EXPORT void criAtomExAsr_UpdateEffectParameters() { }
EXPORT void criAtomExAsr_SetEffectParameter() { }
EXPORT float criAtomExAsr_GetEffectParameter() { return 0.0f; }
EXPORT bool criAtomExAsr_RegisterEffectInterface() { return true; }
EXPORT void criAtomExAsr_UnregisterEffectInterface() { }
EXPORT void criAtomExAsr_EnableBinauralizer() { }
EXPORT bool criAtomExAsr_IsEnabledBinauralizer() { return true; }
EXPORT void criAtomExAsr_PauseOutputVoice() { }
EXPORT int32_t criAtomExAsrRack_GetNumBuses() { return 0; }
EXPORT void criAtomExAsr_GetBusVolumeByName() { }
EXPORT void* criAtomEx3dListener_Create() { return NULL; }
EXPORT void criAtomEx3dListener_Destroy() { }
EXPORT void criAtomEx3dListener_Update() { }
EXPORT void criAtomEx3dListener_ResetParameters() { }
EXPORT void criAtomEx3dListener_SetPosition() { }
EXPORT void criAtomEx3dListener_SetVelocity() { }
EXPORT void criAtomEx3dListener_SetOrientation() { }
EXPORT void criAtomEx3dListener_SetDistanceFactor() { }
EXPORT void criAtomEx3dListener_SetDopplerMultiplier() { }
EXPORT void criAtomEx3dListener_SetFocusPoint() { }
EXPORT void criAtomEx3dListener_SetDistanceFocusLevel() { }
EXPORT void criAtomEx3dListener_SetDirectionFocusLevel() { }
EXPORT bool criAtomEx3dListener_IsDestroyable() { return true; }
EXPORT void criAtomEx3dListener_Set3dRegionHn() { }
EXPORT void* criAtomEx3dSource_Create() { return NULL; }
EXPORT void criAtomEx3dSource_Destroy() { }
EXPORT void criAtomEx3dSource_Update() { }
EXPORT void criAtomEx3dSource_ResetParameters() { }
EXPORT void criAtomEx3dSource_SetPosition() { }
EXPORT void criAtomEx3dSource_SetVelocity() { }
EXPORT void criAtomEx3dSource_SetOrientation() { }
EXPORT void criAtomEx3dSource_SetConeOrientation() { }
EXPORT void criAtomEx3dSource_SetConeParameter() { }
EXPORT void criAtomEx3dSource_SetMinMaxAttenuationDistance() { }
EXPORT void criAtomEx3dSource_SetInteriorPanField() { }
EXPORT void criAtomEx3dSource_SetDopplerFactor() { }
EXPORT void criAtomEx3dSource_SetVolume() { }
EXPORT void criAtomEx3dSource_SetMaxAngleAisacDelta() { }
EXPORT void criAtomEx3dSource_SetAttenuationDistanceSetting() { }
EXPORT bool criAtomEx3dSource_GetAttenuationDistanceSetting() { return true; }
EXPORT void criAtomEx3dSource_SetRandomPositionConfig() { }
EXPORT void criAtomEx3dSource_SetRandomPositionList() { }
EXPORT void criAtomEx3dSource_SetDistanceAisacControlId() { }
EXPORT bool criAtomEx3dSource_IsDestroyable() { return true; }
EXPORT void criAtomEx3dSource_GetPosition() { }
EXPORT void criAtomEx3dSource_Set3dRegionHn() { }
EXPORT void criAtomEx3dSource_SetListenerBasedElevationAngleAisacControlId() { }
EXPORT void criAtomEx3dSource_SetSourceBasedElevationAngleAisacControlId() { }
EXPORT void* criAtomExAcb_LoadAcbFile() { return NULL; }
EXPORT void* criAtomExAcb_LoadAcbData() { return NULL; }
EXPORT void criAtomExAcb_Release() { }
EXPORT int32_t criAtomExAcb_GetNumCues() { return 0; }
EXPORT bool criAtomExAcb_ExistsId() { return true; }
EXPORT bool criAtomExAcb_ExistsName() { return true; }
EXPORT int32_t criAtomExAcb_GetNumUsableAisacControlsById() { return 0; }
EXPORT int32_t criAtomExAcb_GetNumUsableAisacControlsByName() { return 0; }
EXPORT bool criAtomExAcb_GetUsableAisacControlById() { return true; }
EXPORT bool criAtomExAcb_GetUsableAisacControlByName() { return true; }
EXPORT bool criAtomExAcb_GetWaveformInfoById() { return true; }
EXPORT bool criAtomExAcb_GetWaveformInfoByName() { return true; }
EXPORT bool criAtomExAcb_GetCueInfoByName() { return true; }
EXPORT bool criAtomExAcb_GetCueInfoById() { return true; }
EXPORT bool criAtomExAcb_GetCueInfoByIndex() { return true; }
EXPORT int32_t criAtomExAcb_GetNumCuePlayingCountByName() { return 0; }
EXPORT int32_t criAtomExAcb_GetNumCuePlayingCountById() { return 0; }
EXPORT int32_t criAtomExAcb_GetBlockIndexById() { return 0; }
EXPORT int32_t criAtomExAcb_GetBlockIndexByName() { return 0; }
EXPORT void criAtomExAcb_ResetCueTypeStateByName() { }
EXPORT void criAtomExAcb_ResetCueTypeStateById() { }
EXPORT void criAtomExAcb_AttachAwbFile() { }
EXPORT void criAtomExAcb_DetachAwbFile() { }
EXPORT bool criAtomExAcb_IsReadyToRelease() { return true; }
EXPORT bool criAtomExAcb_IsAttachedAwbFile() { return true; }
EXPORT void* criAtomExAcbLoader_Create() { return NULL; }
EXPORT void criAtomExAcbLoader_Destroy() { }
EXPORT bool criAtomExAcbLoader_LoadAcbFileAsync() { return true; }
EXPORT bool criAtomExAcbLoader_LoadAcbDataAsync() { return true; }
EXPORT void criAtomExAcbLoader_GetStatus() { }
EXPORT bool criAtomExAcbLoader_WaitForCompletion() { return true; }
EXPORT void* criAtomExAcbLoader_MoveAcbHandle() { return NULL; }
EXPORT int32_t criAtomExAcf_GetNumAisacControls() { return 0; }
EXPORT bool criAtomExAcf_GetAisacControlInfo() { return true; }
EXPORT int32_t criAtomExAcf_GetAisacControlIdByName() { return 0; }
EXPORT void criAtomExAcf_GetAisacControlNameById() { }
EXPORT int32_t criAtomExAcf_GetNumDspSettings() { return 0; }
EXPORT int32_t criAtomExAcf_GetNumDspSettingsFromAcfData() { return 0; }
EXPORT void* criAtomExAcf_GetDspSettingNameByIndex() { return NULL; }
EXPORT void* criAtomExAcf_GetDspSettingNameByIndexFromAcfData() { return NULL; }
EXPORT bool criAtomExAcf_GetDspSettingInformation() { return true; }
EXPORT bool criAtomExAcf_GetDspSettingSnapshotInformation() { return true; }
EXPORT bool criAtomExAcf_GetDspBusInformation() { return true; }
EXPORT int32_t criAtomExAcf_GetDspFxType() { return 0; }
EXPORT void criAtomExAcf_GetDspFxName() { }
EXPORT bool criAtomExAcf_GetDspFxParameters() { return true; }
EXPORT bool criAtomExAcf_GetDspBusLinkInformation() { return true; }
EXPORT int32_t criAtomExAcf_GetNumCategoriesFromAcfData() { return 0; }
EXPORT int32_t criAtomExAcf_GetNumCategories() { return 0; }
EXPORT int32_t criAtomExAcf_GetNumCategoriesPerPlaybackFromAcfData() { return 0; }
EXPORT int32_t criAtomExAcf_GetNumCategoriesPerPlayback() { return 0; }
EXPORT bool criAtomExAcf_GetCategoryInfo() { return true; }
EXPORT bool criAtomExAcf_GetCategoryInfoByName() { return true; }
EXPORT bool criAtomExAcf_GetCategoryInfoById() { return true; }
EXPORT int32_t criAtomExAcf_GetNumGlobalAisacs() { return 0; }
EXPORT bool criAtomExAcf_GetGlobalAisacInfo() { return true; }
EXPORT bool criAtomExAcf_GetGlobalAisacInfoByName() { return true; }
EXPORT bool criAtomExAcf_GetGlobalAisacGraphInfo() { return true; }
EXPORT bool criAtomExAcf_GetGlobalAisacValue() { return true; }
EXPORT bool criAtomExAcf_GetAcfInfo() { return true; }
EXPORT bool criAtomExAcf_GetAcfInfoFromAcfData() { return true; }
EXPORT int32_t criAtomExAcf_GetNumSelectors() { return 0; }
EXPORT bool criAtomExAcf_GetSelectorInfoByIndex() { return true; }
EXPORT bool criAtomExAcf_GetSelectorInfoByName() { return true; }
EXPORT bool criAtomExAcf_GetSelectorLabelInfo() { return true; }
EXPORT int32_t criAtomExAcf_GetNumBusesFromAcfData() { return 0; }
EXPORT int32_t criAtomExAcf_GetNumBuses() { return 0; }
EXPORT int32_t criAtomExAcf_GetMaxBusesOfDspBusSettingsFromAcfData() { return 0; }
EXPORT int32_t criAtomExAcf_GetMaxBusesOfDspBusSettings() { return 0; }
EXPORT void criAtomExAcf_FindBusName() { }
EXPORT void* criAtomExAcf_GetOutputPortHnByName() { return NULL; }
EXPORT int32_t criAtomExAsrRack_Create() { return 0; }
EXPORT int32_t criAtomUnityAsrRack_Create() { return 0; }
EXPORT void criAtomExAsrRack_Destroy() { }
EXPORT void criAtomExAsrRack_AttachDspBusSetting() { }
EXPORT void criAtomExAsrRack_DetachDspBusSetting() { }
EXPORT void* criAtomExAsrRack_GetAppliedDspBusSnapshotName() { return NULL; }
EXPORT void criAtomExAsrRack_ApplyDspBusSnapshot() { }
EXPORT void criAtomExAsrRack_SetDefaultConfig_Macro() { }
EXPORT void criAtomExAsrRack_GetPerformanceInfo() { }
EXPORT void criAtomExAsrRack_ResetPerformanceMonitor() { }
EXPORT void criAtomExAsrRack_SetAisacControlById() { }
EXPORT void criAtomExAsrRack_SetAisacControlByName() { }
EXPORT void criAtomExAsrRack_GetNumRenderedSamples() { }
EXPORT int32_t criAtomExAsrRack_GetAmbisonicRackId() { return 0; }
EXPORT int32_t criAtomExAsrRack_GetChannelBasedAudioRackId() { return 0; }
EXPORT int32_t criAtomExAsrRack_GetObjectBasedAudioRackId() { return 0; }
EXPORT int32_t criAtomExAsrRack_GetPassThroughRackId() { return 0; }
EXPORT void* criAtomAuxIn_Create() { return NULL; }
EXPORT void criAtomAuxIn_Destroy() { }
EXPORT void criAtomAuxIn_Start() { }
EXPORT void criAtomAuxIn_Stop() { }
EXPORT void criAtomAuxIn_SetVolume() { }
EXPORT void criAtomAuxIn_SetFrequencyRatio() { }
EXPORT void criAtomAuxIn_SetBusSendLevelByName() { }
EXPORT void criAtomAuxIn_SetFormat() { }
EXPORT void criAtomAuxIn_GetFormat() { }
EXPORT void criAtomAuxIn_SetInputReadStream() { }
EXPORT void criAtomMicUnity_Initialize() { }
EXPORT void criAtomMicUnity_Finalize() { }
EXPORT int32_t criAtomMic_GetNumDevices() { return 0; }
EXPORT bool criAtomMic_GetDevice() { return true; }
EXPORT bool criAtomMic_GetDefaultDevice() { return true; }
EXPORT bool criAtomMic_IsFormatSupported() { return true; }
EXPORT void* criAtomMic_Create() { return NULL; }
EXPORT void criAtomMic_Destroy() { }
EXPORT void criAtomMic_Start() { }
EXPORT void criAtomMic_Stop() { }
EXPORT int32_t criAtomMic_GetNumChannels() { return 0; }
EXPORT int32_t criAtomMic_GetSamplingRate() { return 0; }
EXPORT int32_t criAtomMic_GetNumBufferedSamples() { return 0; }
EXPORT bool criAtomMic_IsAvailable() { return true; }
EXPORT int32_t criAtomMic_ReadData() { return 0; }
EXPORT void criAtomMic_SetOutputWriteStream() { }
EXPORT void* criAtomMic_GetOutputReadStream() { return NULL; }
EXPORT int32_t criAtomMic_CalculateWorkSizeForEffect() { return 0; }
EXPORT void* criAtomMic_AttachEffect() { return NULL; }
EXPORT void criAtomMic_DetachEffect() { }
EXPORT void* criAtomMic_GetEffectInstance() { return NULL; }
EXPORT void criAtomMic_SetEffectBypass() { }
EXPORT void criAtomMic_SetEffectParameter() { }
EXPORT float criAtomMic_GetEffectParameter() { return 0.0f; }
EXPORT void criAtomMic_UpdateEffectParameters() { }
EXPORT void* criAtomExOutputAnalyzer_Create() { return NULL; }
EXPORT void criAtomExOutputAnalyzer_Destroy() { }
EXPORT void criAtomExOutputAnalyzer_AttachExPlayer() { }
EXPORT void criAtomExOutputAnalyzer_DetachExPlayer() { }
EXPORT void criAtomExOutputAnalyzer_AttachDspBusByName() { }
EXPORT void criAtomExOutputAnalyzer_DetachDspBusByName() { }
EXPORT float criAtomExOutputAnalyzer_GetRms() { return 0.0f; }
EXPORT void* criAtomExOutputAnalyzer_GetSpectrumLevels() { return NULL; }
EXPORT void* criAtomExOutputAnalyzer_GetPcmData() { return NULL; }
EXPORT void criAtomExOutputAnalyzer_ExecuteQueuedPcmCapturerCallbacks() { }
EXPORT void criAtomExPlayback_Stop() { }
EXPORT void criAtomExPlayback_StopWithoutReleaseTime() { }
EXPORT void criAtomExPlayback_Pause() { }
EXPORT void criAtomExPlayback_Resume() { }
EXPORT bool criAtomExPlayback_IsPaused() { return true; }
EXPORT void criAtomExPlayback_GetStatus() { }
EXPORT bool criAtomExPlayback_GetFormatInfo() { return true; }
EXPORT int64_t criAtomExPlayback_GetTime() { return 0; }
EXPORT int64_t criAtomExPlayback_GetTimeSyncedWithAudio() { return 0; }
EXPORT bool criAtomExPlayback_GetNumPlayedSamples() { return true; }
EXPORT int64_t criAtomExPlayback_GetSequencePosition() { return 0; }
EXPORT void criAtomExPlayback_SetNextBlockIndex() { }
EXPORT int32_t criAtomExPlayback_GetCurrentBlockIndex() { return 0; }
EXPORT bool criAtomExPlayback_GetPlaybackTrackInfo() { return true; }
EXPORT bool criAtomExPlayback_GetBeatSyncInfo() { return true; }
EXPORT bool criAtomExPlayback_SetBeatSyncOffset() { return true; }
EXPORT void* criAtomExPlayer_Create() { return NULL; }
EXPORT void criAtomExPlayer_Destroy() { }
EXPORT void criAtomExPlayer_SetCueId() { }
EXPORT void criAtomExPlayer_SetCueName() { }
EXPORT void criAtomExPlayer_SetCueIndex() { }
EXPORT void criAtomExPlayer_SetFile() { }
EXPORT void criAtomExPlayer_SetData() { }
EXPORT void criAtomExPlayer_SetContentId() { }
EXPORT void criAtomExPlayer_SetVoicePoolIdentifier() { }
EXPORT int32_t criAtomExPlayer_Start() { return 0; }
EXPORT int32_t criAtomExPlayer_Prepare() { return 0; }
EXPORT int32_t criAtomExPlayer_StartAsync() { return 0; }
EXPORT void criAtomExPlayer_StopAsync() { }
EXPORT int32_t criAtomExPlayer_IsReadyToStartAsync() { return 0; }
EXPORT int32_t criAtomExPlayer_GetLastPlaybackId() { return 0; }
EXPORT void criAtomExPlayer_Stop() { }
EXPORT void criAtomExPlayer_StopWithoutReleaseTime() { }
EXPORT void criAtomExPlayer_Pause() { }
EXPORT void criAtomExPlayer_Resume() { }
EXPORT bool criAtomExPlayer_IsPaused() { return true; }
EXPORT void criAtomExPlayer_GetStatus() { }
EXPORT int64_t criAtomExPlayer_GetTime() { return 0; }
EXPORT void criAtomExPlayer_SetFormat() { }
EXPORT void criAtomExPlayer_SetNumChannels() { }
EXPORT void criAtomExPlayer_SetSamplingRate() { }
EXPORT void* criAtomUnityEntryPool_Create() { return NULL; }
EXPORT void criAtomUnityEntryPool_Destroy() { }
EXPORT int32_t criAtomUnityEntryPool_GetNumEntries() { return 0; }
EXPORT int32_t criAtomUnityEntryPool_GetNumConsumedEntries() { return 0; }
EXPORT void criAtomUnityEntryPool_ResetCount() { }
EXPORT bool criAtomUnityEntryPool_EntryFile() { return true; }
EXPORT bool criAtomUnityEntryPool_EntryContentId() { return true; }
EXPORT bool criAtomUnityEntryPool_EntryData() { return true; }
EXPORT bool criAtomUnityEntryPool_EntryCue() { return true; }
EXPORT void criAtomUnityEntryPool_Clear() { }
EXPORT void criAtomExPlayer_SetStartTime() { }
EXPORT void criAtomExPlayer_SetStartTimeMicro() { }
EXPORT void criAtomExPlayer_SetSequencePrepareTime() { }
EXPORT void criAtomExPlayer_LimitLoopCount() { }
EXPORT void criAtomExPlayer_Update() { }
EXPORT void criAtomExPlayer_UpdateAll() { }
EXPORT void criAtomExPlayer_ResetParameters() { }
EXPORT float criAtomExPlayer_GetParameterFloat32() { return 0.0f; }
EXPORT int32_t criAtomExPlayer_GetParameterUint32() { return 0; }
EXPORT int32_t criAtomExPlayer_GetParameterSint32() { return 0; }
EXPORT void* criAtomExPlayer_GetPlayerParameter() { return NULL; }
EXPORT void criAtomExPlayerParameter_RemoveParameter() { }
EXPORT void criAtomExPlayer_SetVolume() { }
EXPORT void criAtomExPlayer_SetPitch() { }
EXPORT void criAtomExPlayer_SetPlaybackRatio() { }
EXPORT void criAtomExPlayer_SetPan3dAngle() { }
EXPORT void criAtomExPlayer_SetPan3dInteriorDistance() { }
EXPORT void criAtomExPlayer_SetPan3dVolume() { }
EXPORT void criAtomExPlayer_SetPanType() { }
EXPORT void criAtomExPlayer_SetSendLevel() { }
EXPORT void criAtomExPlayer_SetBusSendLevel() { }
EXPORT void criAtomExPlayer_SetBusSendLevelByName() { }
EXPORT bool criAtomExPlayer_GetBusSendLevelByName() { return true; }
EXPORT void criAtomExPlayer_SetBusSendLevelOffset() { }
EXPORT void criAtomExPlayer_SetBusSendLevelOffsetByName() { }
EXPORT bool criAtomExPlayer_GetBusSendLevelOffsetByName() { return true; }
EXPORT void criAtomExPlayer_SetBandpassFilterParameters() { }
EXPORT void criAtomExPlayer_SetBiquadFilterParameters() { }
EXPORT void criAtomExPlayer_SetVoicePriority() { }
EXPORT void criAtomExPlayer_SetVoiceControlMethod() { }
EXPORT void criAtomExPlayer_SetAisacControlById() { }
EXPORT void criAtomExPlayer_SetAisacControlByName() { }
EXPORT void criAtomExPlayer_Set3dSourceHn() { }
EXPORT void criAtomExPlayer_Set3dListenerHn() { }
EXPORT void criAtomExPlayer_SetCategoryById() { }
EXPORT void criAtomExPlayer_SetCategoryByName() { }
EXPORT void criAtomExPlayer_UnsetCategory() { }
EXPORT void criAtomExPlayer_SetCuePriority() { }
EXPORT void criAtomExPlayer_SetPreDelayTime() { }
EXPORT void criAtomExPlayer_SetEnvelopeAttackTime() { }
EXPORT void criAtomExPlayer_SetEnvelopeHoldTime() { }
EXPORT void criAtomExPlayer_SetEnvelopeDecayTime() { }
EXPORT void criAtomExPlayer_SetEnvelopeReleaseTime() { }
EXPORT void criAtomExPlayer_SetEnvelopeSustainLevel() { }
EXPORT void criAtomExPlayer_AttachFader() { }
EXPORT void criAtomExPlayer_AttachAisac() { }
EXPORT void criAtomExPlayer_DetachAisac() { }
EXPORT void criAtomExPlayer_DetachFader() { }
EXPORT void criAtomExPlayer_SetFadeOutTime() { }
EXPORT void criAtomExPlayer_SetFadeInTime() { }
EXPORT void criAtomExPlayer_SetFadeInStartOffset() { }
EXPORT void criAtomExPlayer_SetFadeOutEndDelay() { }
EXPORT bool criAtomExPlayer_IsFading() { return true; }
EXPORT void criAtomExPlayer_ResetFaderParameters() { }
EXPORT void criAtomExPlayer_SetGroupNumber() { }
EXPORT bool criAtomExPlayer_GetAttachedAisacInfo() { return true; }
EXPORT void criAtomExPlayer_SetFirstBlockIndex() { }
EXPORT void criAtomExPlayer_SetSelectorLabel() { }
EXPORT void criAtomExPlayer_UnsetSelectorLabel() { }
EXPORT void criAtomExPlayer_ClearSelectorLabels() { }
EXPORT void criAtomExPlayer_SetSoundRendererType() { }
EXPORT void criAtomExPlayer_SetRandomSeed() { }
EXPORT void criAtomExPlayer_Loop() { }
EXPORT void criAtomExPlayer_SetAsrRackId() { }
EXPORT void criAtomExPlayer_SetDspParameter() { }
EXPORT void criAtomExPlayer_AttachTween() { }
EXPORT void criAtomExPlayer_DetachTween() { }
EXPORT void criAtomExPlayer_DetachTweenAll() { }
EXPORT void criAtomExPlayer_SetEnvelopeAttackCurve() { }
EXPORT void criAtomExPlayer_SetEnvelopeDecayCurve() { }
EXPORT void criAtomExPlayer_SetEnvelopeReleaseCurve() { }
EXPORT void criAtomExPlayer_AddOutputPort() { }
EXPORT void criAtomExPlayer_RemoveOutputPort() { }
EXPORT void criAtomExPlayer_ClearOutputPorts() { }
EXPORT void criAtomExPlayer_AddPreferredOutputPort() { }
EXPORT void criAtomExPlayer_RemovePreferredOutputPort() { }
EXPORT void criAtomExPlayer_RemovePreferredOutputPortByName() { }
EXPORT void criAtomExPlayer_ClearPreferredOutputPorts() { }
EXPORT void criAtomExPlayer_SetScheduleTime() { }
EXPORT void* criAtomExSoundObject_Create() { return NULL; }
EXPORT void criAtomExSoundObject_Destroy() { }
EXPORT void criAtomExSoundObject_AddPlayer() { }
EXPORT void criAtomExSoundObject_DeletePlayer() { }
EXPORT void criAtomExSoundObject_DeleteAllPlayers() { }
EXPORT void* criAtomExTween_Create() { return NULL; }
EXPORT void criAtomExTween_Destroy() { }
EXPORT float criAtomExTween_GetValue() { return 0.0f; }
EXPORT void criAtomExTween_MoveTo() { }
EXPORT void criAtomExTween_MoveFrom() { }
EXPORT void criAtomExTween_Stop() { }
EXPORT void criAtomExTween_Reset() { }
EXPORT bool criAtomExTween_IsActive() { return true; }
EXPORT void criAtomUnity_GetNumUsedVoices() { }
EXPORT void criAtomExVoicePool_GetNumUsedVoices() { }
EXPORT void criAtomExVoicePool_Free() { }
EXPORT void criAtomExVoicePool_AttachDspTimeStretch() { }
EXPORT void criAtomExVoicePool_AttachDspPitchShifter() { }
EXPORT void criAtomExVoicePool_DetachDsp() { }
EXPORT void* criAtomExVoicePool_AllocateStandardVoicePool() { return NULL; }
EXPORT void criAtomExVoicePool_SetDefaultConfigForStandardVoicePool_Macro() { }
EXPORT void* criAtomExVoicePool_AllocateWaveVoicePool() { return NULL; }
EXPORT void criAtomExVoicePool_SetDefaultConfigForWaveVoicePool_Macro() { }
EXPORT void* criAtomExVoicePool_AllocateRawPcmVoicePool() { return NULL; }
EXPORT int32_t criWareUnity_GetVersionNumber() { return 38082304; /* 2.45.26 */ }
EXPORT void criAtomExDebug_GetResourcesInfo() { }
EXPORT int32_t criAtomExAcb_GetAcbInfo() { return 0; }
EXPORT int32_t criAtomExPlayback_GetParameterFloat32() { return 0; }
EXPORT int32_t criAtomExPlayback_GetParameterUint32() { return 0; }
EXPORT int32_t criAtomExPlayback_GetParameterSint32() { return 0; }
EXPORT int32_t criAtomExPlayback_GetAisacControlById() { return 0; }
EXPORT int32_t criAtomExPlayback_GetAisacControlByName() { return 0; }
