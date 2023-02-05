# FlowableGitHubSearcher


## 이 프로젝트는
Github API를 사용하여 Repository를 검색 후 결과를 노출하고, 선택한 레포지토리로 이동하는 기능을 갖춘 어플리케이션 입니다.   
<br>
어플리케이션 시작후 상단의 검색창에서 Repository 이름을 검색하면 일치하는 결과가 화면에 나타납니다.   
결과 중 하나를 선택하면 디테일한 정보와 해당 repository의 Github page로 이동할 수 있는 버튼이 노출됩니다.   
이 버튼을 누르면 해당 웹페이지로 이동하여 repository를 띄웁니다. 
<br><br>


<img src="https://user-images.githubusercontent.com/45508297/191397442-9c421fa3-f862-4af9-9b57-0ab0798b5df2.png" width="25%" height="50%" title="" alt="1"></img>
<img src="https://user-images.githubusercontent.com/45508297/191397440-15be09e1-e721-4f6d-bd2b-6ef7d9fe461c.png" width="25%" height="50%" title="" alt="2"></img>
<img src="https://user-images.githubusercontent.com/45508297/191397435-445724c4-f91a-43bf-acb2-4d1cec1bbafa.png" width="25%" height="50%" title="" alt="3"></img>

<br><br>
     
## 사용기술 
#### Architect & Reactive
- RxFlow, RxSwift, RxCocoa
#### Network
- Alamofire, Moya
#### UI Helper
- Kingfisher, Lottie, Snapkit, Then
#### Logger
- SwiftyBeaver

<br><br>

-------
<br>

RxFlow 를 사용하여 Storyboard나 Segue같은 시스템에 종속된 네비게이션 매커니즘을 사용을 피하고 Coordinator 를 사용하여 화면의 이동과 서비스 프로세스를 분리하였습니다.
<br><br>

<img src="https://user-images.githubusercontent.com/45508297/191404685-c47bd5a4-f7af-432f-a27c-817bc8ac0255.png" width="80%" height="45%" title="" alt="3"></img>


