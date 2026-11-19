using System;
using System.IO;
using UnityEditor;
using UnityEditor.Build;
using UnityEditor.Build.Reporting;
using UnityEditor.SceneManagement;
using UnityEngine;

public static class PortProbeBuild
{
    public static void Export()
    {
        var arguments = Environment.GetCommandLineArgs();
        var index = Array.IndexOf(arguments, "-customBuildPath");
        if (index < 0 || index + 1 >= arguments.Length)
            throw new ArgumentException("Supply -customBuildPath with the Xcode export directory.");

        if (EditorUserBuildSettings.activeBuildTarget != BuildTarget.iOS)
            throw new InvalidOperationException("Start Unity with -buildTarget iOS.");

        PlayerSettings.SetScriptingBackend(NamedBuildTarget.iOS, ScriptingImplementation.IL2CPP);
        PlayerSettings.SetApplicationIdentifier(NamedBuildTarget.iOS, "dev.portprobe.ios");
        PlayerSettings.SetManagedStrippingLevel(NamedBuildTarget.iOS, ManagedStrippingLevel.Low);

        const string ScenePath = "Assets/Generated/PortProbe.unity";
        Directory.CreateDirectory("Assets/Generated");
        AssetDatabase.Refresh();
        var scene = EditorSceneManager.NewScene(NewSceneSetup.EmptyScene, NewSceneMode.Single);
        new GameObject("Port Probe").AddComponent<ProbeBehaviour>();
        var camera = new GameObject("Camera").AddComponent<Camera>();
        camera.clearFlags = CameraClearFlags.SolidColor;
        camera.backgroundColor = new Color(0.12f, 0.15f, 0.20f);
        if (!EditorSceneManager.SaveScene(scene, ScenePath))
            throw new IOException($"Could not save {ScenePath}.");

        var report = BuildPipeline.BuildPlayer(new BuildPlayerOptions
        {
            scenes = new[] { ScenePath },
            locationPathName = Path.GetFullPath(arguments[index + 1]),
            target = BuildTarget.iOS,
        });
        if (report.summary.result != BuildResult.Succeeded)
            throw new InvalidOperationException($"Unity iOS export failed: {report.summary.result}.");
    }
}
