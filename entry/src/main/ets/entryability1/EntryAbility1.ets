import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import mobPush from '@zztsdk/mobpush';

export default class EntryAbility1 extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
    mobPush.notificationClickAck(want)
    if (want) {
      if (want.parameters) {
        if (want.parameters["pushData"]) {
          console.log("pushData:" + JSON.stringify((want.parameters["pushData"])))
        }
        if (want.parameters["schemeData"]) {
          console.log("schemeData:" + JSON.stringify((want.parameters["schemeData"])))
        }
      }
    }
  }

  onDestroy(): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    windowStage.loadContent('pages/PageB', (err) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content.');
    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }

  onNewWant(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    console.log("EntryAbilityB onNewWant")
    mobPush.notificationClickAck(want)
    if (want) {
      if (want.parameters) {
        if (want.parameters["pushData"]) {
          console.log("pushData:" + JSON.stringify((want.parameters["pushData"])))
        }
        if (want.parameters["schemeData"]) {
          console.log("schemeData:" + JSON.stringify((want.parameters["schemeData"])))
        }
      }
    }
  }
}
