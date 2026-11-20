#include <stddef.h>
#include <stdint.h>
#include <dlfcn.h>
#include <sched.h>
#include <pthread.h>
#include <mach/mach.h>
#include <mach/semaphore.h>

// ============================================================================
// Unity Engine Class & Module Registration for iOS IL2CPP Runtime
// ============================================================================

template <typename T> void RegisterUnityClass(const char*);
template <typename T> void RegisterStrippedType(int, const char*, const char*);

void InvokeRegisterStaticallyLinkedModuleClasses()
{
    // In stripped AOT mode, granular static linkage is used instead.
}

// RegisterAllStrippedInternalCalls() is generated dynamically from libiPhone-lib.a
// in UnityICallRegistration.cpp to ensure all engine internal calls (icalls) are available.

extern "C" void RegisterModule_AssetBundle();

extern "C" void RegisterStaticallyLinkedModulesGranular()
{
    void RegisterModule_SharedInternals();
    RegisterModule_SharedInternals();

    void RegisterModule_Core();
    RegisterModule_Core();

    // Register the callbacks that initialize the AssetBundle filesystem interface.
    RegisterModule_AssetBundle();

    void RegisterModule_Animation();
    RegisterModule_Animation();

    void RegisterModule_Audio();
    RegisterModule_Audio();

    void RegisterModule_InputLegacy();
    RegisterModule_InputLegacy();

    void RegisterModule_IMGUI();
    RegisterModule_IMGUI();

    void RegisterModule_JSONSerialize();
    RegisterModule_JSONSerialize();

    void RegisterModule_Physics();
    RegisterModule_Physics();

    void RegisterModule_Physics2D();
    RegisterModule_Physics2D();

    void RegisterModule_TextRendering();
    RegisterModule_TextRendering();

    void RegisterModule_UI();
    RegisterModule_UI();

    void RegisterModule_UIElements();
    RegisterModule_UIElements();

    void RegisterModule_ImageConversion();
    RegisterModule_ImageConversion();

    void RegisterModule_GameCenter();
    RegisterModule_GameCenter();

    void RegisterModule_ParticleSystem();
    RegisterModule_ParticleSystem();

    void RegisterModule_ScreenCapture();
    RegisterModule_ScreenCapture();

    void RegisterModule_SpriteMask();
    RegisterModule_SpriteMask();

    void RegisterModule_SpriteShape();
    RegisterModule_SpriteShape();

    void RegisterModule_Streaming();
    RegisterModule_Streaming();

    void RegisterModule_Subsystems();
    RegisterModule_Subsystems();

    void RegisterModule_TLS();
    RegisterModule_TLS();

    void RegisterModule_UnityConnect();
    RegisterModule_UnityConnect();

    void RegisterModule_UnityAnalytics();
    RegisterModule_UnityAnalytics();

    void RegisterModule_UnityWebRequest();
    RegisterModule_UnityWebRequest();

    void RegisterModule_UnityWebRequestAssetBundle();
    RegisterModule_UnityWebRequestAssetBundle();

    void RegisterModule_UnityWebRequestAudio();
    RegisterModule_UnityWebRequestAudio();

    void RegisterModule_UnityWebRequestTexture();
    RegisterModule_UnityWebRequestTexture();

    void RegisterModule_Video();
    RegisterModule_Video();

    void RegisterModule_VFX();
    RegisterModule_VFX();

    void RegisterModule_AI();
    RegisterModule_AI();

    void RegisterModule_RuntimeInitializeOnLoadManagerInitializer();
    RegisterModule_RuntimeInitializeOnLoadManagerInitializer();
}

// ----------------------------------------------------------------------------
// Engine Class Declarations
// ----------------------------------------------------------------------------

class EditorExtension; template <> void RegisterUnityClass<EditorExtension>(const char*);
namespace Unity { class Component; } template <> void RegisterUnityClass<Unity::Component>(const char*);
class Behaviour; template <> void RegisterUnityClass<Behaviour>(const char*);
class NamedObject; template <> void RegisterUnityClass<NamedObject>(const char*);
class GameObject; template <> void RegisterUnityClass<GameObject>(const char*);
class Transform; template <> void RegisterUnityClass<Transform>(const char*);
class Camera; template <> void RegisterUnityClass<Camera>(const char*);
class Material; template <> void RegisterUnityClass<Material>(const char*);
class Mesh; template <> void RegisterUnityClass<Mesh>(const char*);
class MeshFilter; template <> void RegisterUnityClass<MeshFilter>(const char*);
class Renderer; template <> void RegisterUnityClass<Renderer>(const char*);
class MeshRenderer; template <> void RegisterUnityClass<MeshRenderer>(const char*);
class SkinnedMeshRenderer; template <> void RegisterUnityClass<SkinnedMeshRenderer>(const char*);
class Texture; template <> void RegisterUnityClass<Texture>(const char*);
class Texture2D; template <> void RegisterUnityClass<Texture2D>(const char*);
class Texture2DArray; template <> void RegisterUnityClass<Texture2DArray>(const char*);
class Texture3D; template <> void RegisterUnityClass<Texture3D>(const char*);
class Cubemap; template <> void RegisterUnityClass<Cubemap>(const char*);
class CubemapArray; template <> void RegisterUnityClass<CubemapArray>(const char*);
class RenderTexture; template <> void RegisterUnityClass<RenderTexture>(const char*);
class LowerResBlitTexture; template <> void RegisterUnityClass<LowerResBlitTexture>(const char*);
class Shader; template <> void RegisterUnityClass<Shader>(const char*);
class ShaderNameRegistry; template <> void RegisterUnityClass<ShaderNameRegistry>(const char*);
class ComputeShader; template <> void RegisterUnityClass<ComputeShader>(const char*);
class TextAsset; template <> void RegisterUnityClass<TextAsset>(const char*);
class Sprite; template <> void RegisterUnityClass<Sprite>(const char*);
class SpriteAtlas; template <> void RegisterUnityClass<SpriteAtlas>(const char*);
class SpriteRenderer; template <> void RegisterUnityClass<SpriteRenderer>(const char*);
class Light; template <> void RegisterUnityClass<Light>(const char*);
class LightProbes; template <> void RegisterUnityClass<LightProbes>(const char*);
class ReflectionProbe; template <> void RegisterUnityClass<ReflectionProbe>(const char*);
class LightmapSettings; template <> void RegisterUnityClass<LightmapSettings>(const char*);
class LightingSettings; template <> void RegisterUnityClass<LightingSettings>(const char*);
class RenderSettings; template <> void RegisterUnityClass<RenderSettings>(const char*);
class QualitySettings; template <> void RegisterUnityClass<QualitySettings>(const char*);
class GraphicsSettings; template <> void RegisterUnityClass<GraphicsSettings>(const char*);
class TimeManager; template <> void RegisterUnityClass<TimeManager>(const char*);
class InputManager; template <> void RegisterUnityClass<InputManager>(const char*);
class TagManager; template <> void RegisterUnityClass<TagManager>(const char*);
class DelayedCallManager; template <> void RegisterUnityClass<DelayedCallManager>(const char*);
class BuildSettings; template <> void RegisterUnityClass<BuildSettings>(const char*);
class PlayerSettings; template <> void RegisterUnityClass<PlayerSettings>(const char*);
class ResourceManager; template <> void RegisterUnityClass<ResourceManager>(const char*);
class RuntimeInitializeOnLoadManager; template <> void RegisterUnityClass<RuntimeInitializeOnLoadManager>(const char*);
class MonoScript; template <> void RegisterUnityClass<MonoScript>(const char*);
class MonoBehaviour; template <> void RegisterUnityClass<MonoBehaviour>(const char*);
class MonoManager; template <> void RegisterUnityClass<MonoManager>(const char*);
class PreloadData; template <> void RegisterUnityClass<PreloadData>(const char*);
class GameManager; template <> void RegisterUnityClass<GameManager>(const char*);
class GlobalGameManager; template <> void RegisterUnityClass<GlobalGameManager>(const char*);
class LevelGameManager; template <> void RegisterUnityClass<LevelGameManager>(const char*);
class FlareLayer; template <> void RegisterUnityClass<FlareLayer>(const char*);
class LineRenderer; template <> void RegisterUnityClass<LineRenderer>(const char*);
class TrailRenderer; template <> void RegisterUnityClass<TrailRenderer>(const char*);
class StreamingManager; template <> void RegisterUnityClass<StreamingManager>(const char*);

namespace UI { class RectTransform; } template <> void RegisterUnityClass<UI::RectTransform>(const char*);
namespace UI { class Canvas; } template <> void RegisterUnityClass<UI::Canvas>(const char*);
namespace UI { class CanvasGroup; } template <> void RegisterUnityClass<UI::CanvasGroup>(const char*);
namespace UI { class CanvasRenderer; } template <> void RegisterUnityClass<UI::CanvasRenderer>(const char*);

namespace TextRendering { class Font; } template <> void RegisterUnityClass<TextRendering::Font>(const char*);
namespace TextRenderingPrivate { class TextMesh; } template <> void RegisterUnityClass<TextRenderingPrivate::TextMesh>(const char*);

// Animation Module
class Animator; template <> void RegisterUnityClass<Animator>(const char*);
class AnimatorController; template <> void RegisterUnityClass<AnimatorController>(const char*);
class AnimatorOverrideController; template <> void RegisterUnityClass<AnimatorOverrideController>(const char*);
class RuntimeAnimatorController; template <> void RegisterUnityClass<RuntimeAnimatorController>(const char*);
class Motion; template <> void RegisterUnityClass<Motion>(const char*);
class AnimationClip; template <> void RegisterUnityClass<AnimationClip>(const char*);
class Avatar; template <> void RegisterUnityClass<Avatar>(const char*);

// Audio Module
class AudioManager; template <> void RegisterUnityClass<AudioManager>(const char*);
class AudioBehaviour; template <> void RegisterUnityClass<AudioBehaviour>(const char*);
class AudioListener; template <> void RegisterUnityClass<AudioListener>(const char*);
class AudioSource; template <> void RegisterUnityClass<AudioSource>(const char*);
class AudioClip; template <> void RegisterUnityClass<AudioClip>(const char*);
class SampleClip; template <> void RegisterUnityClass<SampleClip>(const char*);
class AudioMixer; template <> void RegisterUnityClass<AudioMixer>(const char*);
class AudioMixerGroup; template <> void RegisterUnityClass<AudioMixerGroup>(const char*);
class AudioMixerSnapshot; template <> void RegisterUnityClass<AudioMixerSnapshot>(const char*);

// Physics 3D Module
class PhysicsManager; template <> void RegisterUnityClass<PhysicsManager>(const char*);
class Rigidbody; template <> void RegisterUnityClass<Rigidbody>(const char*);
class Collider; template <> void RegisterUnityClass<Collider>(const char*);
class BoxCollider; template <> void RegisterUnityClass<BoxCollider>(const char*);
class SphereCollider; template <> void RegisterUnityClass<SphereCollider>(const char*);
class CapsuleCollider; template <> void RegisterUnityClass<CapsuleCollider>(const char*);
class MeshCollider; template <> void RegisterUnityClass<MeshCollider>(const char*);
class CharacterController; template <> void RegisterUnityClass<CharacterController>(const char*);

// Physics 2D Module
class Physics2DSettings; template <> void RegisterUnityClass<Physics2DSettings>(const char*);
class Rigidbody2D; template <> void RegisterUnityClass<Rigidbody2D>(const char*);
class Collider2D; template <> void RegisterUnityClass<Collider2D>(const char*);
class BoxCollider2D; template <> void RegisterUnityClass<BoxCollider2D>(const char*);
class CircleCollider2D; template <> void RegisterUnityClass<CircleCollider2D>(const char*);
class PhysicsMaterial2D; template <> void RegisterUnityClass<PhysicsMaterial2D>(const char*);

// Particle System Module
class ParticleSystem; template <> void RegisterUnityClass<ParticleSystem>(const char*);
class ParticleSystemRenderer; template <> void RegisterUnityClass<ParticleSystemRenderer>(const char*);

// Video Module
class VideoPlayer; template <> void RegisterUnityClass<VideoPlayer>(const char*);
class VideoClip; template <> void RegisterUnityClass<VideoClip>(const char*);

// AssetBundle & Engine Services
class AssetBundle; template <> void RegisterUnityClass<AssetBundle>(const char*);
class UnityConnectSettings; template <> void RegisterUnityClass<UnityConnectSettings>(const char*);
class VFXManager; template <> void RegisterUnityClass<VFXManager>(const char*);
class NavMeshSettings; template <> void RegisterUnityClass<NavMeshSettings>(const char*);
class NavMeshProjectSettings; template <> void RegisterUnityClass<NavMeshProjectSettings>(const char*);

// ----------------------------------------------------------------------------
// Master Class Registration Function
// ----------------------------------------------------------------------------

void RegisterAllClasses()
{
    void RegisterBuiltinTypes();
    RegisterBuiltinTypes();

    // Core Classes
    RegisterUnityClass<EditorExtension>("Core");
    RegisterUnityClass<Unity::Component>("Core");
    RegisterUnityClass<Behaviour>("Core");
    RegisterUnityClass<NamedObject>("Core");
    RegisterUnityClass<GameObject>("Core");
    RegisterUnityClass<Transform>("Core");
    RegisterUnityClass<Camera>("Core");
    RegisterUnityClass<Material>("Core");
    RegisterUnityClass<Mesh>("Core");
    RegisterUnityClass<MeshFilter>("Core");
    RegisterUnityClass<Renderer>("Core");
    RegisterUnityClass<MeshRenderer>("Core");
    RegisterUnityClass<SkinnedMeshRenderer>("Core");
    RegisterUnityClass<Texture>("Core");
    RegisterUnityClass<Texture2D>("Core");
    RegisterUnityClass<Texture2DArray>("Core");
    RegisterUnityClass<Texture3D>("Core");
    RegisterUnityClass<Cubemap>("Core");
    RegisterUnityClass<CubemapArray>("Core");
    RegisterUnityClass<RenderTexture>("Core");
    RegisterUnityClass<LowerResBlitTexture>("Core");
    RegisterUnityClass<Shader>("Core");
    // The serialized ShaderNameRegistry manager (class ID 94) must be
    // registered before globalgamemanagers is loaded for the first render.
    RegisterUnityClass<ShaderNameRegistry>("Core");
    RegisterUnityClass<ComputeShader>("Core");
    RegisterUnityClass<TextAsset>("Core");
    RegisterUnityClass<Sprite>("Core");
    RegisterUnityClass<SpriteAtlas>("Core");
    RegisterUnityClass<SpriteRenderer>("Core");
    RegisterUnityClass<Light>("Core");
    RegisterUnityClass<LightProbes>("Core");
    RegisterUnityClass<ReflectionProbe>("Core");
    RegisterUnityClass<LightmapSettings>("Core");
    RegisterUnityClass<LightingSettings>("Core");
    RegisterUnityClass<RenderSettings>("Core");
    RegisterUnityClass<QualitySettings>("Core");
    RegisterUnityClass<GraphicsSettings>("Core");
    RegisterUnityClass<TimeManager>("Core");
    RegisterUnityClass<InputManager>("Core");
    RegisterUnityClass<TagManager>("Core");
    RegisterUnityClass<DelayedCallManager>("Core");
    RegisterUnityClass<BuildSettings>("Core");
    RegisterUnityClass<PlayerSettings>("Core");
    RegisterUnityClass<ResourceManager>("Core");
    RegisterUnityClass<RuntimeInitializeOnLoadManager>("Core");
    RegisterUnityClass<MonoScript>("Core");
    RegisterUnityClass<MonoBehaviour>("Core");
    RegisterUnityClass<MonoManager>("Core");
    RegisterUnityClass<PreloadData>("Core");
    RegisterUnityClass<GameManager>("Core");
    RegisterUnityClass<GlobalGameManager>("Core");
    RegisterUnityClass<LevelGameManager>("Core");
    RegisterUnityClass<FlareLayer>("Core");
    RegisterUnityClass<LineRenderer>("Core");
    RegisterUnityClass<TrailRenderer>("Core");
    RegisterUnityClass<StreamingManager>("Core");

    // UI & Text
    RegisterUnityClass<UI::RectTransform>("Core");
    RegisterUnityClass<UI::Canvas>("UI");
    RegisterUnityClass<UI::CanvasGroup>("UI");
    RegisterUnityClass<UI::CanvasRenderer>("UI");
    RegisterUnityClass<TextRendering::Font>("TextRendering");
    RegisterUnityClass<TextRenderingPrivate::TextMesh>("TextRendering");

    // Animation
    RegisterUnityClass<Animator>("Animation");
    RegisterUnityClass<AnimatorController>("Animation");
    RegisterUnityClass<AnimatorOverrideController>("Animation");
    RegisterUnityClass<RuntimeAnimatorController>("Animation");
    RegisterUnityClass<Motion>("Animation");
    RegisterUnityClass<AnimationClip>("Animation");
    RegisterUnityClass<Avatar>("Animation");

    // Audio
    RegisterUnityClass<AudioManager>("Audio");
    RegisterUnityClass<AudioBehaviour>("Audio");
    RegisterUnityClass<AudioListener>("Audio");
    RegisterUnityClass<AudioSource>("Audio");
    RegisterUnityClass<AudioClip>("Audio");
    RegisterUnityClass<SampleClip>("Audio");
    RegisterUnityClass<AudioMixer>("Audio");
    RegisterUnityClass<AudioMixerGroup>("Audio");
    RegisterUnityClass<AudioMixerSnapshot>("Audio");

    // Physics 3D
    RegisterUnityClass<PhysicsManager>("Physics");
    RegisterUnityClass<Rigidbody>("Physics");
    RegisterUnityClass<Collider>("Physics");
    RegisterUnityClass<BoxCollider>("Physics");
    RegisterUnityClass<SphereCollider>("Physics");
    RegisterUnityClass<CapsuleCollider>("Physics");
    RegisterUnityClass<MeshCollider>("Physics");
    RegisterUnityClass<CharacterController>("Physics");

    // Physics 2D
    RegisterUnityClass<Physics2DSettings>("Physics2D");
    RegisterUnityClass<Rigidbody2D>("Physics2D");
    RegisterUnityClass<Collider2D>("Physics2D");
    RegisterUnityClass<BoxCollider2D>("Physics2D");
    RegisterUnityClass<CircleCollider2D>("Physics2D");
    RegisterUnityClass<PhysicsMaterial2D>("Physics2D");

    // Particle System
    RegisterUnityClass<ParticleSystem>("ParticleSystem");
    RegisterUnityClass<ParticleSystemRenderer>("ParticleSystem");

    // Video
    RegisterUnityClass<VideoPlayer>("Video");
    RegisterUnityClass<VideoClip>("Video");

    // AssetBundle & Engine Services
    RegisterUnityClass<AssetBundle>("AssetBundle");
    RegisterUnityClass<UnityConnectSettings>("UnityConnect");
    RegisterUnityClass<VFXManager>("VFX");
    RegisterUnityClass<NavMeshSettings>("AI");
    RegisterUnityClass<NavMeshProjectSettings>("AI");
}

// ============================================================================
// Baselib Posix / Darwin Implementation Stubs under il2cpp_baselib namespace
// ============================================================================

namespace il2cpp_baselib {

struct Baselib_DynamicLibrary_Handle {
    uintptr_t handle;
};

struct Baselib_SystemSemaphore_Handle {
    uintptr_t handle;
};

struct Baselib_ErrorState {};

enum Baselib_ErrorState_ExplainVerbosity {
    Baselib_ErrorState_ExplainVerbosity_ErrorType = 0,
    Baselib_ErrorState_ExplainVerbosity_ErrorType_SourceLocation_Explanation = 1
};

typedef uint64_t Baselib_Thread_Id;

uint32_t Baselib_ErrorState_Explain(
    const Baselib_ErrorState* errorState,
    char* buffer,
    uint32_t bufferLen,
    Baselib_ErrorState_ExplainVerbosity verbosity) {
    if (buffer && bufferLen > 0) {
        buffer[0] = '\0';
    }
    return 1;
}

Baselib_DynamicLibrary_Handle Baselib_DynamicLibrary_OpenUtf8(
    const char* pathnameUtf8,
    Baselib_ErrorState* errorState) {
    void* h = pathnameUtf8 ? ::dlopen(pathnameUtf8, RTLD_LAZY | RTLD_LOCAL) : NULL;
    Baselib_DynamicLibrary_Handle handle;
    handle.handle = (uintptr_t)h;
    return handle;
}

Baselib_DynamicLibrary_Handle Baselib_DynamicLibrary_OpenProgramHandle(
    Baselib_ErrorState* errorState) {
    void* h = ::dlopen(NULL, RTLD_LAZY | RTLD_LOCAL);
    Baselib_DynamicLibrary_Handle handle;
    handle.handle = (uintptr_t)h;
    return handle;
}

void* Baselib_DynamicLibrary_GetFunction(
    Baselib_DynamicLibrary_Handle handle,
    const char* functionName,
    Baselib_ErrorState* errorState) {
    if (handle.handle == 0 || functionName == NULL) return NULL;
    return ::dlsym((void*)handle.handle, functionName);
}

void Baselib_DynamicLibrary_Close(Baselib_DynamicLibrary_Handle handle) {
    if (handle.handle != 0) {
        ::dlclose((void*)handle.handle);
    }
}

void Baselib_Thread_YieldExecution() {
    sched_yield();
}

Baselib_Thread_Id Baselib_Thread_GetCurrentThreadId() {
    uint64_t tid = 0;
    pthread_threadid_np(NULL, &tid);
    return tid;
}

Baselib_SystemSemaphore_Handle Baselib_SystemSemaphore_CreateInplace(void* memoryBlock) {
    semaphore_t sem = 0;
    kern_return_t ret = semaphore_create(mach_task_self(), &sem, SYNC_POLICY_FIFO, 0);
    Baselib_SystemSemaphore_Handle handle;
    handle.handle = (ret == KERN_SUCCESS) ? (uintptr_t)sem : 0;
    if (memoryBlock) {
        *(Baselib_SystemSemaphore_Handle*)memoryBlock = handle;
    }
    return handle;
}

void Baselib_SystemSemaphore_Acquire(Baselib_SystemSemaphore_Handle handle) {
    if (handle.handle != 0) {
        semaphore_wait((semaphore_t)handle.handle);
    }
}

bool Baselib_SystemSemaphore_TryAcquire(Baselib_SystemSemaphore_Handle handle) {
    if (handle.handle == 0) return false;
    mach_timespec_t ts = {0, 0};
    kern_return_t ret = semaphore_timedwait((semaphore_t)handle.handle, ts);
    return (ret == KERN_SUCCESS);
}

bool Baselib_SystemSemaphore_TryTimedAcquire(Baselib_SystemSemaphore_Handle handle, unsigned int timeoutInMilliseconds) {
    if (handle.handle == 0) return false;
    mach_timespec_t ts;
    ts.tv_sec = timeoutInMilliseconds / 1000;
    ts.tv_nsec = (clock_res_t)((timeoutInMilliseconds % 1000) * 1000000);
    kern_return_t ret = semaphore_timedwait((semaphore_t)handle.handle, ts);
    return (ret == KERN_SUCCESS);
}

void Baselib_SystemSemaphore_Release(Baselib_SystemSemaphore_Handle handle, unsigned int count) {
    if (handle.handle != 0) {
        for (unsigned int i = 0; i < count; ++i) {
            semaphore_signal((semaphore_t)handle.handle);
        }
    }
}

void Baselib_SystemSemaphore_FreeInplace(Baselib_SystemSemaphore_Handle handle) {
    if (handle.handle != 0) {
        semaphore_destroy(mach_task_self(), (semaphore_t)handle.handle);
    }
}

} // namespace il2cpp_baselib
