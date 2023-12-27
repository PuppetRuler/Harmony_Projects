import common from '@ohos.app.ability.common'
import Want from '@ohos.app.ability.Want'

@Entry
@Component
struct DocumentPage {
    private context = getContext(this) as common.UIAbilityContext
    @State editTitle: boolean = true
    @State title: string = '标题'
    @State content: string = ''

    build() {
        Row() {
            Column({ space: 10 }) {
                Row() {
                    Image($r('app.media.return'))
                        .width(30)
                        .onClick(() => {
                            // 跳转到文档列表的UIAbility

                            // 跳转到目的地want
                            let want: Want = {
                                deviceId: '',
                                bundleName: 'com.example.helloworld',
                                moduleName: 'entry',
                                abilityName: 'EntryAbility'
                            }
                            // 跳转
                            this.context.startAbility(want)
                        })
                    if (!this.editTitle) {
                        Text(this.title)
                            .fontSize(30)
                            .fontWeight(FontWeight.Bold)
                            .onClick(() => this.editTitle = true)
                        Image($r('app.media.refresh'))
                            .width(30)
                    } else {
                        TextInput({
                            placeholder: '请输入标题',
                            text: this.title
                        })
                            .onChange(v => {
                                this.title = v
                            })
                            .layoutWeight(1)
                        Button('确定')
                            .onClick(() => {
                                this.editTitle = false
                            })
                    }
                }
                .width('100%')
                .justifyContent(FlexAlign.SpaceBetween)

                Divider()
                TextArea()
                    .layoutWeight(1)
            }
            .width('100%')
            .height('100%')
        }
        .height('100%')
    }
}