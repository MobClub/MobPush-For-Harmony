import mobPush from '@mobsdk/mobpush';
import promptAction from '@ohos.promptAction';
import Base from '@ohos.base';
import notificationManager from '@ohos.notificationManager';
import { MobSDK } from '@mobsdk/mobcore';
import { common } from '@kit.AbilityKit';
import abilityAccessCtrl from '@ohos.abilityAccessCtrl';
import { BusinessError } from '@ohos.base';

@Entry
@Component
struct Index {
  setAlias1: string = ""
  setAlias2: string = ""
  addTags1: string = ""
  addTags2: string = ""
  deleteTags1: string = ""
  deleteTags2: string = ""
  badgeCount: number = 0

  build() {
    Scroll() {
      Column() {
        Text("PushSDK DEMO")
          .width('100%')
          .margin(10)
          .align(Alignment.Center)
          .textAlign(TextAlign.Center)

        Button("申请通知权限")
          .onClick(() => {
            notificationManager.requestEnableNotification()
          })
          .width('90%')
          .margin(10)
          .padding(15)

        // Button("申请OAID权限")
        //   .onClick(() => {
        //     let atManager = abilityAccessCtrl.createAtManager();
        //     try {
        //       let context: Context = getContext(this) as common.UIAbilityContext;
        //       atManager.requestPermissionsFromUser(context, ["ohos.permission.APP_TRACKING_CONSENT"]).then((data) => {
        //         console.info("data:" + JSON.stringify(data));
        //         console.info("data permissions:" + data.permissions);
        //         console.info("data authResults:" + data.authResults);
        //       }).catch((err: BusinessError) => {
        //         console.info("data:" + JSON.stringify(err));
        //       })
        //     } catch (err) {
        //       console.log(`catch err->${JSON.stringify(err)}`);
        //     }
        //   })
        //   .width('90%')
        //   .margin(10)
        //   .padding(15)

        Button("MobSDK同意隐私")
          .fontWeight(FontWeight.Bold)
          .onClick(() => {
            MobSDK.submitPolicyGrantResult(true)
          })
          .width('90%')
          .margin(10)
          .padding(15)

        Button("MobSDK拒绝隐私")
          .fontWeight(FontWeight.Bold)
          .onClick(() => {
            MobSDK.submitPolicyGrantResult(false)
          })
          .width('90%')
          .margin(10)
          .padding(15)

        Button("MobSDK初始化")
          .fontWeight(FontWeight.Bold)
          .onClick(() => {
            MobSDK.init(getContext(), "2dbe655e88c80", "a7b9f1918c596eacbff8a172ba8ed158")
          })
          .width('90%')
          .margin(10)
          .padding(15)

        Button("MobPush初始化")
          .fontWeight(FontWeight.Bold)
          .onClick(() => {
            notificationManager.isNotificationEnabled().then((isNotificationEnabled) => {
              if (!isNotificationEnabled) {
                this.showMessage("注意Push初始化时未开启通知权限-无法接收到推送")
              }
            })
            mobPush.init(getContext(), "2dbe655e88c80", "a7b9f1918c596eacbff8a172ba8ed158")
          })
          .width('90%')
          .margin(10)
          .padding(15)

        Button("通知权限是否开启-callback")
          .onClick(() => {
            let isNotificationEnabledCallback = (err: Base.BusinessError, data: boolean): void => {
              let message = ""
              if (err) {
                message = `获取通知权限是否开启失败, code is ${err.code}, message is ${err.message}`;
              } else {
                message = `通知权限是否开启: ${JSON.stringify(data)}`;
              }
              this.showMessage(message)
            }
            mobPush.isNotificationEnabled(isNotificationEnabledCallback)
          }).width('90%')
          .margin(10)
          .padding(15)

        Button("通知权限是否开启-Promise")
          .onClick(() => {
            mobPush.isNotificationEnabled().then((data: boolean) => {
              this.showMessage(`通知权限是否开启: ${data}`)
            })
          }).width('90%')
          .margin(10)
          .padding(15)

        Button("获取RID-callback")
          .onClick(() => {
            let getRegistrationIdCallback = (err: Base.BusinessError, data: string): void => {
              let message = ""
              if (err) {
                message = `获取RID失败, code is ${err.code}, message is ${err.message}`;
              } else {
                message = `RID: ${JSON.stringify(data)}`;
              }
              this.showMessage(message)
            }
            mobPush.getRegistrationId(getRegistrationIdCallback)
          }).width('90%')
          .margin(10)
          .padding(15)

        Button("获取RID-Promise")
          .onClick(() => {
            mobPush.getRegistrationId().then((data: string) => {
              this.showMessage(`RID: ${data}`)
            })
          }).width('90%')
          .margin(10)
          .padding(15)

        Button("stopPush")
          .onClick(() => {
            mobPush.stopPush()
          }).width('90%')
          .margin(10)
          .padding(15)

        Button("restartPush")
          .onClick(() => {
            mobPush.restartPush()
          }).width('90%')
          .margin(10)
          .padding(15)

        Button("isPushStopped")
          .onClick(() => {
            let isStopped = mobPush.isPushStopped()
            this.showMessage("isStopped:" + isStopped)
          }).width('90%')
          .margin(10)
          .padding(15)

        Text("设置别名-callback")
        Row({ space: 5 }) {
          TextArea({
            placeholder: '输入alias',
          }).onChange((value: string) => {
            this.setAlias1 = value
          })
            .width('70%')
          Button("设置别名")
            .onClick(() => {
              console.log("setAlias:" + this.setAlias1)
              let setAliasCallback = (err: Base.BusinessError, data: mobPush.AliasResult): void => {
                this.showMessage("setAlias:" + JSON.stringify(data))
              }
              mobPush.setAlias(this.setAlias1, setAliasCallback)
            }).width('30%')
        }.width('90%')
        .margin(10)

        Text("设置别名-Promise")
        Row({ space: 5 }) {
          TextArea({
            placeholder: '输入alias',
          }).onChange((value: string) => {
            this.setAlias2 = value
          })
            .width('70%')
          Button("设置别名")
            .onClick(() => {
              console.log("setAlias:" + this.setAlias2)
              mobPush.setAlias(this.setAlias2).then((data: mobPush.AliasResult) => {
                this.showMessage("setAlias:" + JSON.stringify(data))
              })
            }).width('30%')
        }.width('90%')
        .margin(10)

        Button("获取别名-callback")
          .onClick(() => {
            let getRegistrationIdCallback = (err: Base.BusinessError, data: mobPush.AliasResult): void => {
              this.showMessage("getAlias:" + JSON.stringify(data))
            }
            mobPush.getAlias(getRegistrationIdCallback)
          }).width('90%')
          .margin(10)
          .padding(15)

        Button("获取别名-Promise")
          .onClick(() => {
            mobPush.getAlias().then((data: mobPush.AliasResult) => {
              this.showMessage("getAlias:" + JSON.stringify(data))
            })
          }).width('90%')
          .margin(10)
          .padding(15)

        Button("删除别名-callback")
          .onClick(() => {
            let getRegistrationIdCallback = (err: Base.BusinessError, data: mobPush.AliasResult): void => {
              this.showMessage("deleteAlias:" + JSON.stringify(data))
            }
            mobPush.deleteAlias(getRegistrationIdCallback)
          }).width('90%')
          .margin(10)
          .padding(15)

        Button("删除别名-Promise")
          .onClick(() => {
            mobPush.deleteAlias().then((data: mobPush.AliasResult) => {
              this.showMessage("deleteAlias:" + JSON.stringify(data))
            })
          }).width('90%')
          .margin(10)
          .padding(15)

        Text("设置标签 以,分隔-callback")
        Row({ space: 5 }) {
          TextArea({
            placeholder: '输入tags',
          }).onChange((value: string) => {
            this.addTags1 = value
          })
            .width('70%')
          Button("设置标签")
            .onClick(() => {
              let tags = this.addTags1.split(",")
              console.log("addTags:" + tags)
              let setAliasCallback = (err: Base.BusinessError, data: mobPush.TagsResult): void => {
                this.showMessage("addTags:" + JSON.stringify(data))
              }
              mobPush.addTags(tags, setAliasCallback)
            }).width('30%')
        }.width('90%')
        .margin(10)

        Text("设置标签 以,分隔-Promise")
        Row({ space: 5 }) {
          TextArea({
            placeholder: '输入tags',
          }).onChange((value: string) => {
            this.addTags2 = value
          }).width('70%')
          Button("设置标签")
            .onClick(() => {
              let tags = this.addTags2.split(",")
              console.log("addTags:" + tags)
              mobPush.addTags(tags).then((data: mobPush.TagsResult) => {
                this.showMessage("addTags:" + JSON.stringify(data))
              })
            }).width('30%')
        }.width('90%')
        .margin(10)

        Button("获取标签-callback")
          .onClick(() => {
            let getRegistrationIdCallback = (err: Base.BusinessError, data: mobPush.TagsResult): void => {
              this.showMessage("getTags:" + JSON.stringify(data))
            }
            mobPush.getTags(getRegistrationIdCallback)
          }).width('90%')
          .margin(10)
          .padding(15)

        Button("获取标签-Promise")
          .onClick(() => {
            mobPush.getTags().then((data: mobPush.TagsResult) => {
              this.showMessage("getTags:" + JSON.stringify(data))
            })
          }).width('90%')
          .margin(10)
          .padding(15)

        Text("删除标签 以,分隔-callback")
        Row({ space: 5 }) {
          TextArea({
            placeholder: '输入tags',
          }).onChange((value: string) => {
            this.deleteTags1 = value
          })
            .width('70%')
          Button("删除标签")
            .onClick(() => {
              let tags = this.deleteTags1.split(",")
              console.log("deleteTags:" + tags)
              let setAliasCallback = (err: Base.BusinessError, data: mobPush.TagsResult): void => {
                this.showMessage("deleteTags:" + JSON.stringify(data))
              }
              mobPush.deleteTags(tags, setAliasCallback)
            }).width('30%')
        }.width('90%')
        .margin(10)

        Text("删除标签 以,分隔-Promise")
        Row({ space: 5 }) {
          TextArea({
            placeholder: '输入tags',
          }).onChange((value: string) => {
            this.deleteTags2 = value
          }).width('70%')
          Button("删除标签")
            .onClick(() => {
              let tags = this.deleteTags2.split(",")
              console.log("deleteTags:" + tags)
              mobPush.deleteTags(tags).then((data: mobPush.TagsResult) => {
                this.showMessage("deleteTags:" + JSON.stringify(data))
              })
            }).width('30%')
        }.width('90%')

        Button("清除标签-callback")
          .onClick(() => {
            let getRegistrationIdCallback = (err: Base.BusinessError, data: mobPush.TagsResult): void => {
              this.showMessage("cleanTags:" + JSON.stringify(data))
            }
            mobPush.cleanTags(getRegistrationIdCallback)
          })
          .width('90%')
          .margin(10)
          .padding(15)

        Button("清除标签-Promise")
          .onClick(() => {
            mobPush.cleanTags().then((data: mobPush.TagsResult) => {
              this.showMessage("cleanTags:" + JSON.stringify(data))
            })
          })
          .width('90%')
          .margin(10)
          .padding(15)
          .margin(10)
        Button("显示角标")
          .onClick(() => {
            mobPush.setShowBadge(true)
          })
          .width('90%')
          .margin(10)
          .padding(15)
        Button("关闭角标")
          .onClick(() => {
            mobPush.setShowBadge(false)
          })
          .width('90%')
          .margin(10)
          .padding(15)
        Button("获取角标是否显示")
          .onClick(() => {
            this.showMessage("角标显示：" + mobPush.getShowBadge())
          })
          .width('90%')
          .margin(10)
          .padding(15)
        Row({ space: 5 }) {
          TextArea({
            placeholder: '输入角标数',
          }).type(TextAreaType.NUMBER)
            .onChange((value: string) => {
              this.badgeCount = Number(value)
            }).width('50%')
          Button("设置角标数")
            .onClick(() => {
              console.log("设置角标数:" + this.badgeCount)
              mobPush.setBadgeCounts(this.badgeCount)
            }).width('50%')
        }.width('90%')

        Button("清除所有通知")
          .onClick(() => {
            mobPush.clearAllNotification()
          })
          .width('90%')
          .margin(10)
          .padding(15)
        Button("获取厂商Token")
          .onClick(() => {
            this.showMessage("厂商Toke:" + mobPush.getDeviceToken())
          })
          .width('90%')
          .margin(10)
          .padding(15)

        Button("获取TCP状态-callback")
          .onClick(() => {
            let isNotificationEnabledCallback = (data: boolean): void => {
              let message = `TCP状态: ${JSON.stringify(data)}`;
              this.showMessage(message)
            }
            mobPush.checkTcpStatus(isNotificationEnabledCallback)
          }).width('90%')
          .margin(10)
          .padding(15)

        Button("获取TCP状态-Promise")
          .onClick(() => {
            mobPush.checkTcpStatus().then((data: boolean) => {
              this.showMessage(`TCP状态: ${data}`)
            })
          }).width('90%')
          .margin(10)
          .padding(15)
      }
      .width('100%')
    }
    .height('100%')
    .align(Alignment.Top)
  }

  showMessage(message: string) {
    console.log(message)
    promptAction.showToast({
      message: message,
      duration: 2000
    });
  }
}

