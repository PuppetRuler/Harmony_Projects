import router from '@ohos.router'
import RouterInfo from '../viewmodel/RouterInfo'
import IndexFontSizePanel from '../views/IndexFontSizePanel'
import Preferences from '../common/util/PreferencesUtil'

@Entry
@Component
struct Index {
    @State message: string = '页面列表'
    @State showPanel: boolean = false
    @Provide fontSize: number = 16
    private routers: RouterInfo[] = [
        new RouterInfo('pages/ImagePage', '图片查看案例'),
        new RouterInfo('pages/ItemPage', '商品列表案例'),
        new RouterInfo('pages/StatePage', 'Jack和他的女友案例'),
        new RouterInfo('pages/PropPage', '人物列表案例'),
        new RouterInfo('pages/AnimationPage','小鱼动画案例'),
        new RouterInfo('pages/LifeCirclePage','生命周期案例1'),
        new RouterInfo('pages/DocumentListPage','UIAbility启动模式案例'),
        new RouterInfo('pages/ShopPage','查询商铺案例'),
        new RouterInfo('pages/TaskManage','任务列表持久化案例'),
        new RouterInfo('pages/NotificationPage','通知案例')
    ]

    tag:string = 'Index Page'
    // 页面生命周期
    async aboutToAppear(){
        console.log(this.tag,'about to appear')
        this.fontSize = await Preferences.getPreferenceValue('MyPreferences','IndexFontSize',this.fontSize) as number
    }

    onPageShow(){
        console.log(this.tag,'on page show')
    }

    onBackPress(){
        console.log(this.tag,'on back press')
    }

    onPageHide(){
        console.log(this.tag,'on page hide')
    }

    aboutToDisappear(){
        console.log(this.tag,'about to disappear')
    }

    build() {
        Column() {
            // 首页标题
            this.Title()

            // 导航列表
            List({ space: 15 }) {
                ForEach(
                    this.routers,
                    (router, index) => {
                        ListItem() {
                            this.RouterItem(router, index + 1)
                        }
                    }
                )
            }
            .layoutWeight(1)
            .alignListItem(ListItemAlign.Center)
            .width("100%")
            .height("100%")

            // 字体修改面板
            if(this.showPanel){
                IndexFontSizePanel()
                    .transition({
                        translate: { y: 115 }
                    })
            }
        }
    }

    @Builder
    RouterItem(r: RouterInfo, i: number) {
        Row() {
            Text(i + '.')
                .fontSize(this.fontSize)
                .fontColor(Color.White)
            Blank()
            Text(r.title)
                .fontSize(this.fontSize)
                .fontColor(Color.White)
        }
        .width('90%')
        .padding(12)
        .backgroundColor('#38f')
        .borderRadius(20)
        .shadow({radius:6,color:'#4F000000',offsetX:2,offsetY:4})
        .onClick(()=>{
            // 路由跳转
            router.pushUrl(
                {
                    url:r.url,
                    params:{id:i}
                },
                router.RouterMode.Single,
                err => {
                    if(err) {
                        console.log(`路由错误，errCode:${err.code},errMsg:${err.data}`)
                    }
                }
            )
        })
    }

    @Builder
    Title(){
        Row(){
            Text(this.message)
                .fontSize(50)
                .fontWeight(FontWeight.Bold)
                .height(80)
            Image($r('app.media.ic_public_settings'))
                .width(30)
                .onClick(() => {
                    animateTo({ duration: 500, curve: Curve.EaseOut }, () => this.showPanel = !this.showPanel)
                })
        }
        .justifyContent(FlexAlign.SpaceEvenly)
        .width('100%')
    }
}