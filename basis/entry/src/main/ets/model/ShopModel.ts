import http from '@ohos.net.http';
import ShopInfo from '../viewmodel/ShopInfo';
import axios from '@ohos/axios'

class ShopModel {
  baseURL: string = 'http://localhost:3000'
  pageNo: number = 1

  /**
   * 基于axios实现异步查询商铺
   * @returns
   */
  getShopListByAxios(): Promise<ShopInfo[]> {
    return new Promise((resolve, reject) => {
      axios.get(
        `${this.baseURL}/shops`,
        {
          params: { pageNo: this.pageNo, pageSize: 3 }
        }
      )
        .then(resp => {
          if (resp.status === 200) {
            // 查询成功
            console.log('testTag',  '查询商铺成功！', JSON.stringify(resp.data))
            resolve(resp.data)
          } else {
            console.log('testTag',  '查询商铺信息失败！error:', JSON.stringify(resp))
            reject('查询商铺失败')
          }
        })
        .catch(error => {
          console.log('testTag',  '查询商铺信息失败！error:', JSON.stringify(error))
          reject('查询商铺失败')
        })
    })
  }

  /**
   * 基于ohos的http模块实现异步查询商铺
   * @returns
   */
  getShopListByHttp(): Promise<ShopInfo[]> {
    return new Promise((resolve, reject) => {
      // 1.创建http的请求对象
      let httpRequest = http.createHttp()
      // 2.发送请求
      httpRequest.request(
        `${this.baseURL}/shops?pageNo=${this.pageNo}&pageSize=3`,
        {
          method: http.RequestMethod.GET
        }
      )
        .then(resp => {
          if (resp.responseCode === 200) {
            // 查询成功
            console.log('testTag',  '查询商铺成功！', resp.result)
            resolve(JSON.parse(resp.result.toString()))
          } else {
            console.log('testTag',  '查询商铺信息失败！error:', JSON.stringify(resp))
            reject('查询商铺失败')
          }
        })
        .catch(error => {
          console.log('testTag',  '查询商铺信息失败！error:', JSON.stringify(error))
          reject('查询商铺失败')
        })
    })
  }

  /**
   * 基于axios实现同步查询商铺
   * @returns
   */
  async getShopListByAxiosAsync(): Promise<ShopInfo[]> {
    // 1.发送请求
    let resp = await axios.get(
      `${this.baseURL}/shops`,
      {
        params: { pageNo: this.pageNo, pageSize: 3 }
      }
    )
    // 2.处理响应
    if (resp.status === 200) {
      // 查询成功
      console.log('testTag', '查询商铺成功！', JSON.stringify(resp.data))
      return resp.data;
    }
    // 查询失败
    console.log('testTag', '查询商铺信息失败！error:', JSON.stringify(resp))
  }

  /**
   * 基于ohos的http模块实现同步查询商铺
   * @returns
   */
  async getShopListByHttpAsync(): Promise<ShopInfo[]> {
    // 1.创建http的请求对象
    let httpRequest = http.createHttp()
    // 2.发送请求
    let resp = await httpRequest.request(
      `${this.baseURL}/shops?pageNo=${this.pageNo}&pageSize=3`,
      {
        method: http.RequestMethod.GET
      }
    )
    // 3.处理响应
    if (resp.responseCode === 200) {
      // 查询成功
      console.log('testTag', '查询商铺成功！', resp.result)
      return JSON.parse(resp.result.toString());
    }
    console.log('testTag', '查询商铺信息失败！error:', JSON.stringify(resp))
  }
}

const shopModel = new ShopModel();

export default shopModel as ShopModel;