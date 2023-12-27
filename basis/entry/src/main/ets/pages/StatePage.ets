import { Header } from '../components/commonComponents'
@Entry
@Component
struct StatePage {
    @State message: string = 'Hello World'

    build() {
        Column() {
            Header()
            Row() {
                Column() {
                    Text(this.message)
                        .fontSize(50)
                        .fontColor('#36D')
                        .fontWeight(FontWeight.Bold)
                        .onClick(() => {
                            this.message = 'Hello ArkTS'
                        })
                    // Image('https://img-api-hk.boxmoe.com/large/9bd9b167gy1fwsgraj058j21hc0u0kjl.jpg?apiboxmoe')
                    Image($r('app.media.icon'))
                        .width(250)
                        .interpolation(ImageInterpolation.High)
                }
                .width('100%')
            }
            .height('100%')
        }
    }
}