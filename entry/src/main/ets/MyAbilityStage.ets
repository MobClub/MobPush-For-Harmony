import AbilityStage from '@ohos.app.ability.AbilityStage';
import { HashMap } from '@kit.ArkTS';
import mobPush from '@zztsdk/mobpush';
import { promptAction } from '@kit.ArkUI';
import { HashonHelper, ZztSDK } from '@zztsdk/zztcore';


export default class MyAbilityStage extends AbilityStage {
  onCreate() {
    ZztSDK.init(this.context, "2dbe655e88c80", "a7b9f1918c596eacbff8a172ba8ed158")
    let receive: mobPush.MobPushReceiver = {
      onCustomMessageReceive: (message: mobPush.MobPushCustomMessage) => {
        let msg = "onCustomMessageReceive:" + HashonHelper.fromMap(HashonHelper.parseObject(message))
        let extMap = HashonHelper.fromMap(message.extrasMap as Map<string, object>)
        msg = msg + ",extrasMap:" + extMap
        console.log(msg)
        this.showMessage(msg)
      },
      onNotifyMessageReceive: (message: mobPush.MobPushNotifyMessage) => {
        let msg = "onNotifyMessageReceive:" + HashonHelper.fromMap(HashonHelper.parseObject(message))
        let extMap = HashonHelper.fromMap(message.extrasMap as Map<string, object>)
        msg = msg + ",extrasMap:" + extMap
        console.log(msg)
        this.showMessage(msg)
      },
      onNotifyMessageOpenedReceive: (message: mobPush.MobPushNotifyMessage) => {
        let msg = "onNotifyMessageOpenedReceive:" + HashonHelper.fromMap(HashonHelper.parseObject(message))
        let extMap = HashonHelper.fromMap(message.extrasMap as Map<string, object>)
        msg = msg + ",extrasMap:" + extMap
        console.log(msg)
        this.showMessage(msg)
      },
      onCommandReceive: (type: number, map: HashMap<string, Object>) => {
        let msg = "channel:" + map.get(mobPush.KEY_CHANNEL) + ",token:" + map.get(mobPush.KEY_TOKEN) + ",message:" + map.get(mobPush.KEY_MESSAGE)
        console.log(msg)
        this.showMessage("onCommandReceive:Type:" + type + ",message:" + msg)
      }
    }
    mobPush.addPushReceiver(receive)
    let gfReceive: mobPush.MobPushGeofenceReceiver = {
      onGeofenceReceiver: (data: mobPush.MobPushGeofence[]): void => {
        let msg = "触发地理围栏：" + JSON.stringify(data)
        console.log(msg)
        this.showMessage(msg)
      }
    }
    mobPush.setGeofenceReceiver(gfReceive)

    let inAppReceive: mobPush.MobPushInAppMessageReceiver = {
      onInAppMessageReceive: (message: mobPush.MobPushInAppMessage): void => {
        //应用内消息到达
        let msg = "onInAppMessageReceive" + JSON.stringify(message)
        console.log(msg)
        this.showMessage(msg)
      },
      onInAppMessageShow: (message: mobPush.MobPushInAppMessage): void => {
        //应用内消息展示
        let msg = "onInAppMessageShow" + JSON.stringify(message)
        console.log(msg)
        this.showMessage(msg)
      },
      onInAppMessageClick: (message: mobPush.MobPushInAppMessage): void => {
        //应用内消息点击
        let msg = "onInAppMessageClick" + JSON.stringify(message)
        console.log(msg)
        this.showMessage(msg)
      }
    }
    mobPush.setInAppMessageReceiver(inAppReceive)
  }

  showMessage(message: string) {
    promptAction.showToast({
      message: message,
      duration: 2000
    });
  }
}