# Unity iOS AOT lab

这个仓库用于验证 Unity 桌面发行物向 iOS 迁移的 AOT 路线。Alice in Cradle 0.30i 的 macOS 安装包是只读分析样本。仓库里的探针代码是独立自建样本。

## 在专用 Mac 环境运行

准备已激活的 Unity 2022.3.62f2、对应的 iOS Build Support、Xcode 和 .NET SDK 8 或更高版本。以下命令在仓库根目录运行。根据你的安装位置设置编辑器路径。

```bash
UNITY_EDITOR="/Applications/Unity/Hub/Editor/2022.3.62f2/Unity.app/Contents/MacOS/Unity"
bash scripts/prepare-unity-probe.sh
"$UNITY_EDITOR" -batchmode -nographics -quit -projectPath "$PWD/UnityProbe" \
  -buildTarget iOS -executeMethod PortProbeBuild.Export \
  -customBuildPath "$PWD/build/ProbeXcode" -logFile -
bash scripts/build-xcode.sh "$PWD/build/ProbeXcode/Unity-iPhone.xcodeproj" \
  "$PWD/build/unity-ios-unsigned.zip"
```

探针将预先编译的 IL DLL 作为 Unity 托管插件导入。为真机签名后，启动应显示 `IL2CPP` 和固定运算结果。通过 Xcode 打开导出的工程即可配置自己的签名团队和设备。

## GitHub Actions

- 两个工作流都由 `workflow_dispatch` 手动触发。
- **iOS ARM64 AOT probe** 在 macOS runner 上把预编译的 .NET Standard IL DLL 链进 .NET NativeAOT 动态库。工作流检查 Mach-O 的 ARM64 架构、iOS 平台标记和 C 导出符号。产物是构建验证用的原生库。它验证 CI 上的跨目标编译链，Unity 游戏的 AOT 后端是下一个工作流使用的 IL2CPP。 [Microsoft NativeAOT iOS 支持](https://learn.microsoft.com/en-us/dotnet/core/deploying/native-aot/ios-like-platforms/) · [Unity IL2CPP](https://docs.unity3d.com/cn/2022.3/Manual/IL2CPP.html)
- **Unity iOS IL2CPP** 默认构建 `UnityProbe`，也接受仓库内另一个准备好的 Unity 项目路径。GitHub-hosted runner 使用 GameCI。通过仓库的 Actions Secrets 配置 Personal 授权后可运行，成功时上传未签名 `.app` 压缩包。专用 Mac 走上面的命令即可使用已有授权。 [GameCI 授权](https://game.ci/docs/github/activation/) · [Unity iOS 构建](https://docs.unity3d.com/cn/2022.3/Manual/iphone-BuildProcess.html)

## AIC 0.30i 的 AOT 检查

扫描了 25 个应用及相关中间件程序集，共 65,703 个 IL 方法体。游戏核心 `Assembly-CSharp.dll` 和 `unsafeAssem.dll` 中没有检测到直接的 `Reflection.Emit`、运行时程序集加载或 `calli` 指令。两者各有两处字符串按类型查找，需验证裁剪后的类型能否保留。静态扫描只检查可识别的 IL 调用和方法引用。

- 标题场景和主游戏场景都直接挂载 `CriWareInitializer`。现有 CRI 托管层声明 517 个 `cri_ware_unity` P/Invoke 入口，iOS 构建需要配套的原生库和托管层，核对回调 ABI。具体运行路径可能只用到一部分入口。
- `unsafeAssem` 的 `MacGamepadHaptics` 有 6 个原生入口，另有两处启动桌面进程的调用。`SFB` 的文件选择器走 macOS bundle。需要按 iOS 平台适配这些桌面服务。
- Fusion 和 Json.NET 存在反射泛型构造。保留元数据和生成所需泛型实例分别验证。初次编译使用低裁剪或明确保留实际用到的类型，运行时再检查反射路径。 [Unity AOT 限制](https://docs.unity3d.com/2022.3/Documentation/Manual/ScriptingRestrictions.html) · [Unity 代码剥离](https://docs.unity3d.com/cn/2022.3/Manual/ManagedCodeStripping.html)

AIC 的判断顺序是先验证 Unity IL2CPP 样本能处理预编译 IL，再验证场景中的脚本绑定、标题场景 CRI 初始化和 Metal 渲染，最后验收输入、音频、存读档及内存。资源包的兼容性和 Unity 编译结果各需验证。

## 本地审计

```powershell
python -m pip install -r tools/requirements.txt
python tools/aot_audit.py "路径到 Managed" "Assembly-CSharp.dll" "unsafeAssem.dll" "CriMw*.dll"
```

输出是 JSON，含程序集引用、P/Invoke、启动或回调相关特性，以及待人工核实的反射和桌面 API 调用。
