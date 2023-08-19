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
