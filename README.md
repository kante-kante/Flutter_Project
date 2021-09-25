# Flutter 시작하기

- Flutter 앱 만들기 프로젝트
    - flutter로 앱 제작하기
    - 기존에 있던 앱을 클론코딩 or 기존 앱의 불편한점을 개선하여 제작하기
- - - 
1. **C언어는 현재 전 세계적으로 가장 많이 사용하는 언어.**
    - iot 기기의 사용이 많아짐에 따라 사용량이 떨어졌다가 다시 올라감<br/>

2. **자바는 현재 사용 감소중**
    - 저작권 문제 및 다른 좋은 언어가 많음. (Kotlin 등등)
    - 나쁜 언어는 아님. 트렌드를 생각했을 때 다른 폭넓은 언어를 사용하는것이 좋다.<br/>

3. **필드에서는 C, 파이썬을 사용하는 개발자를 원하지만, 파이썬의 사용량은 크게 늘어나지 않음**
    - 우리나라의 관공서가 자바를 사용한 프레임워크 등을 사용하도록 정책이 정해짐.

# Flutter
- **dart 언어로 만들어진 구글에서 제작한 프레임워크**
- 자바스크립트를 대체하기 위해 만들어진 언어
- 언어가 배우기 쉽고 파이썬을 배웠다면 배우기 더 용이.
<br/>

# Flutter 환경 설정

1. **안드로이드 스튜디오 및 jdk 1.8 설치**
    - 라이선스 문제로 인해 jdk 1.8 설치  
    다운로드: [Java SE Development Kit 8 Downloads](https://www.oracle.com/kr/java/technologies/javase/javase-jdk8-downloads.html)

2. **visual studio code 설치**   
    - [Visual Studio Code - Code Editing. Redefined](https://code.visualstudio.com/)

3. **VSCode 플러그인 설치(flutter, dart)**
    - Flutter 플러그인 설치 시, Dart까지 함께 설치.

4. **Flutter 설치**
    - 다운로드: [Flutter Install](https://flutter.dev/docs/get-started/install)

5. 압축을 푼 플러터 폴더를 C 드라이브로 옮기기
    - **경로를 쉽게 설정해주기 위함.**

6. **윈도우 설정 - 고급 시스템 설정 - 환경 변수 - path**
    - 찾아보기 후 다음 경로로 설정
    - C:\flutter_windows_2.2.3-stable\flutter\bin

7. **cmd - flutter doctor** 입력
    - flutter doctor는 플러터 진단 도구.

8. **cmd - 
flutter doctor —android-licenses** 입력
    - 안드로이드 라이센스를 부여하기 위함. jdk 1.8 버전에서 가능.   

9. C드라이브에 작업용 폴더 하나 생성(폴더명은 자유)   

10. vscode - **보기 - 명령 팔레트 - flutter: New Application Project 클릭**
<br/>

11. **작업 폴더 지정 후 신뢰에 체크.(부모 폴더 신뢰)**
<br/>

12. flutlab - build project:hello world - 프로젝트명 지정 후 null safe 체크 (flutlab은 웹에서 진행. 자율)
<br/>

13. 빌드 진행
- - - 
## Dart 메인 코드
- dart에서는 화면에 만들어지는 모든 것들을 **위젯(Wiget)** 이라고 지칭.
- 각 기업에서 지칭하는 디자인 명칭들이 있음   
    - Google: Material Design   
    - Apple: Cupertino Design   
    - MS: Metro Design   

```jsx
import 'package:flutter/material.dart';
// 플러터는 Material Design 사용.
```

- 위젯은 두가지가 있다   
    - **StatelessWidget**: 상태에 대한 변화가 없는 위젯   
    - **StatefulWidget**: 상태에 대한 변화가 있는 위젯   
<br/>

- 안드로이드 스튜디오 대신 [https://flutlab.io/](https://flutlab.io/) 사용 가능.   
단, 2개까지만 무료 버전은 프로젝트 생성 가능하며
학생용 버전은 10개까지 무료로 사용 가능.

- stateful wiget은 상태관리를 따로 둔다.

```dart
return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
	       child: Column(// 여러 줄을 만들 때 사용
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,// 액션버튼 클릭 시 카운터변수 호출. 카운터 증가. 상태 변화
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  
```

- Scaffold - 전체 프레임
- appbar - 앱의 상단바
- body: Center - 중심부
- - - 
❗ **Flutter 사용 시 JAVA_HOME 에러가 발생하는 경우**

[안드로이드 스튜디오에서 플러터 앱 실행시 JAVA_HOME PATH 문제가 발생한다면?](https://www.androidhuman.com/2021-05-28-flutter_android_studio_not_installed)

[JAVA_HOME is set to an invalid directory, Please set the JAVA_HOME variable in your environment to match the location of your Java installation](https://stackoverflow.com/questions/66984617/java-home-is-set-to-an-invalid-directory-please-set-the-java-home-variable-in-y)

- JAVA_HOME 에러가 발생하는 경우 보통 환경변수 설정에서 경로를 잘못잡아주었기 때문
- bin 을 포함한 경로는 안되고, bin 폴더 이전까지의 경로를 경로로 설정한다.

❗ **cmdline-tools 설정 오류가 발생하는 경우**

[I am getting this errors "cmdline-tools component is missing" after installing flutter and android studio... i added andorid sdk. how to solve them?](https://stackoverflow.com/questions/68236007/i-am-getting-this-errors-cmdline-tools-component-is-missing-after-installing-f)

- 안드로이드 스튜디오의 SDK Tools 탭에서 해당 툴 설치
