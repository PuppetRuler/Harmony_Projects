import { CommonConstants } from '../../common/constants/CommonConstants'
@Component
export default struct SearchComponent {
  build() {
    Row({space: CommonConstants.SPACE_6}){
      Search({placeholder:'请输入搜索内容'})
        .textFont({size:18})
        .layoutWeight(1)
      Badge({count:1, position: BadgePosition.RightTop,style:{fontSize:10}}){
        Image($r('app.media.ic_public_email'))
          .width(22)
      }
    }
    .width(CommonConstants.THOUSANDTH_940)
  }
}