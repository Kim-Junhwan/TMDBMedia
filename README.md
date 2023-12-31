# TMDBMedia

## 새싹 20회차 과제

![Simulator_Screen_Recording_-_iPhone_14_Pro_-_2023-08-14_at_08_55_23_AdobeExpress (1)](https://github.com/Kim-Junhwan/TMDBMedia/assets/58679737/527b89a7-c885-4062-be81-b4d0efc91dd1)

## 새싹 22회차 과제

![Simulator Screen Recording - iPhone 14 Pro - 2023-08-19 at 15 33 34](https://github.com/Kim-Junhwan/TMDBMedia/assets/58679737/f2715f2d-e048-451e-a577-a2ac08a77672)

- TMDB TV시리즈 리스트 API, 시즌 API와 시즌별 에피소드를 제공해주는 API를 통한 TV 시리즈 시즌별 에피소드를 제공하는 기능 추가
- CollectionView의 각 섹션은 TV시리즈를 담당, 각 셀은 해당 TV 시리즈의 시즌을 표현
- CollectionViewCell 내부에 다른 CollectionView를 넣어서 시즌별 에피소드를 셀로 표현

### 고민한 점
  
- TV시리즈리스트 API와 TV시리즈 시즌 API는 각각 별개의 API여서 가져온 TV시리즈 리스트를 반복문으로 돌아서 API에 리퀘스트를 돌아야 함
- 하지만 반복문으로 API 리퀘스트를 보내고 응답을 받을때 @escaping 클로저 내부에 콜렉션 뷰를 리로딩할때 요청을 보낸 횟수만큼 콜렉션뷰가 리로딩 되는 문제 발생
- 가져온 TV시리즈 목록의 개수와 시즌의 개수를 비교하여 개수가 같아질 때 콜렉션 뷰를 리로드 하도록 구현

```swift
AF.request("https://api.themoviedb.org/3/tv/top_rated?api_key=\(APIKey.tmdsAPIKey)", method: .get).validate().responseDecodable(of: TVSeriesList.self) { [weak self] result in
            guard let list = result.value else { return }
            self?.tvseriesList = list
            for tvSeries in list.results {
                AF.request("https://api.themoviedb.org/3/tv/\(tvSeries.id)?api_key=\(APIKey.tmdsAPIKey)").validate().responseDecodable(of: TVSeriesSeason.self) { response in
                    guard let fetchTvSeriesSeason = response.value else { return }
                    self?.sectionTVSeriesList[tvSeries.id] = fetchTvSeriesSeason

                    // 가져온 TVSeries 개수와 TVSeriesSeason의 개수가 같아지면 reload 수행
                    if self?.sectionTVSeriesList.count == list.results.count {
                        self?.collectionView.reloadData()
                    }
                }
            }
        }
```

## 새싹 24회차 과제

- 로컬 알람 구현. 매일 오전 8시 30분에 다마고치에게 먹이를 주라는 알림이 띄우도록 구현

## 새싹 27회차 과제


- 위치 버튼 클릭시 현재 위치로 이동

![Simulator Screen Recording - iPhone 14 Pro - 2023-08-23 at 21 01 23](https://github.com/Kim-Junhwan/TMDBMedia/assets/58679737/763ae42f-8a6a-4583-8e33-aee9d6add31d)

- 권한 없을 경우 위치버튼 클릭 시 설정 이동 Alert 추가

![Simulator Screen Recording - iPhone 14 Pro - 2023-08-23 at 21 03 39](https://github.com/Kim-Junhwan/TMDBMedia/assets/58679737/d1c4ab63-e6b7-41ac-baed-5ced9e652448)

- 주변 영화관 지도상에 어노테이션으로 표시 및 필터링
  
![Simulator Screen Recording - iPhone 14 Pro - 2023-08-23 at 21 03 10](https://github.com/Kim-Junhwan/TMDBMedia/assets/58679737/6d4e745e-ac4d-4e0b-a7a1-8b2735d1f9da)

## 새싹 29회차 과제

- UIPageViewController를 이용한 앱 처음 실행시 인트로 화면
  
![Simulator Screen Recording - iPhone 14 Pro - 2023-08-27 at 12 00 26](https://github.com/Kim-Junhwan/TMDBMedia/assets/58679737/62df6b10-fe22-41a0-af6b-5e900de5258c)

## 새싹 31회차 과제

- 프로필 설정화면 구현

클로저를 이용한 데이터 전달을 활용하여 이전 화면에 데이터 전달기능 구현

![Simulator Screen Recording - iPhone 14 Pro - 2023-08-30 at 19 05 42](https://github.com/Kim-Junhwan/TMDBMedia/assets/58679737/214eb1ec-cf19-4c91-ac27-b99416cc6135)

## 새싹 34회차 과제

- 데이터 타입에 따라 다른 셀 보여주기
- 반복적인 네트워크작업을 추상화해 계층으로 나누어 각 책임 분리

가져온 타입이 tv일 경우 tv안테나 셀을, movie일 경우 슬레이트셀을 보여준다.

![Simulator Screen Recording - iPhone 14 Pro - 2023-09-05 at 21 17 58](https://github.com/Kim-Junhwan/TMDBMedia/assets/58679737/dd2c45bd-f2c5-450c-9fec-365a02f96698)

### 네트워크 계층

![image](https://github.com/Kim-Junhwan/TMDBMedia/assets/58679737/33034ecc-081c-4f34-b9de-b79095426c15)

해당 프로젝트에는 총 5개의 API가 사용된다. API를 이용할때마다 같은 코드를 중복작성하게 된다. 중복된 부분을 제거하기 위해 네트워킹 작업을 다음과 같이 분할했다.

- NetworkConfiguration: 기본이 되는 네트워크 설정 객체. API의 기본 URL, header, parameter를 가지고 있음.

```swift
struct NetworkConfiguration {
    var baseURL: URL
    var header: [String:String]
    var queryParameter: [String:String]
}
```

- Endpoint: 세부적인 API의 path와, 해당 API에 들어가야할 query, httpMethod, 응답으로 온 data를 디코딩할 타입을 가지고 있고, 최종적으로 요청할 API URL을 만드는 기능을 가지고 있다.

```swift
struct EndPoint<T>: Networable {
    
    typealias responseType = T
    
    let path: String
    let method: HTTPMethodType
    let decoder: ResponseDecoder
    let queryParameter: Encodable?
    
    init(path: String, method: HTTPMethodType, query: Encodable?) {
        self.path = path
        self.method = method
        self.queryParameter = query
        self.decoder = JSONResponseDecoder()
    }
}
```

- NetworkService: URLSession을 이용해 API 네트워킹 작업을 수행한다.
- DataTransferService: NetworkService로부터 받은 데이터의 값을 Endpoint의 디코딩 타입으로 디코딩을 한다.
