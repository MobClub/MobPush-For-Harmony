import AbilityConstant from '@ohos.app.ability.AbilityConstant';
import hilog from '@ohos.hilog';
import UIAbility from '@ohos.app.ability.UIAbility';
import Want from '@ohos.app.ability.Want';
import window from '@ohos.window';
import mobPush from '@zztsdk/mobpush';

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
    console.log("EntryAbility onCreate")
    mobPush.notificationClickAck(want)
    mobPush.receiveMessage(this)
    if (want) {
      if (want.parameters) {
        console.log("parameters:" + JSON.stringify(want.parameters))
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

    windowStage.loadContent('pages/Index', (err, data) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content. Data: %{public}s', JSON.stringify(data) ?? '');
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
    console.log("EntryAbility onNewWant")
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
