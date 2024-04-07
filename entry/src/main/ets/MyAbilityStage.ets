import AbilityStage from '@ohos.app.ability.AbilityStage';
import { HashMap } from '@kit.ArkTS';
import mobPush from '@mobsdk/mobpush';
import { promptAction } from '@kit.ArkUI';


export default class MyAbilityStage extends AbilityStage {
  onCreate() {
    let receive: mobPush.MobPushReceiver = {
      onCustomMessageReceive: (message: mobPush.MobPushCustomMessage) => {
        let msg = "onCustomMessageReceive:" + JSON.stringify(message)
        console.log(msg)
        this.showMessage(msg)
      },
      onNotifyMessageReceive: (message: mobPush.MobPushNotifyMessage) => {
        let msg = "onNotifyMessageReceive:" + JSON.stringify(message)
        console.log(msg)
        this.showMessage(msg)
      },
      onNotifyMessageOpenedReceive: (message: mobPush.MobPushNotifyMessage) => {
        let msg = "onNotifyMessageOpenedReceive:" + JSON.stringify(message)
        console.log(msg)
        this.showMessage(msg)
      },
      onCommandReceive: (type: number, map: HashMap<string, Object>) => {
        let msg = "channel:" + map.get(mobPush.KEY_CHANNEL) + ",token:" + map.get(mobPush.KEY_TOKEN)
        console.log(msg)
        this.showMessage("onCommandReceive:Type:" + type + ",message:" + msg)
      }
    }
    mobPush.addPushReceiver(receive)
  }

  showMessage(message: string) {
    promptAction.showToast({
      message: message,
      duration: 2000
    });
  }
}