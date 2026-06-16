\# DESIGN\_GUIDE.md



\# Family Care Design System v1.0



\---



\# Brand Identity



\## Service Type



가족 건강 관리 서비스



주요 기능



\* 안심 체크

\* 약 복용 관리

\* 걸음 수 관리

\* 가족 건강 모니터링

\* 건강 리포트



\---



\# Color System



\## Primary



```dart

Primary500 = Color(0xFF10C9A7)

Primary600 = Color(0xFF08B996)

Primary700 = Color(0xFF07967A)

```



사용 위치



\* CTA 버튼

\* 활성 탭

\* 진행률

\* 건강 점수 카드

\* 그래프



\---



\## Primary Light



```dart

Primary50 = Color(0xFFEAFBF7)

Primary100 = Color(0xFFD6F7F0)

```



사용 위치



\* 완료 상태 카드

\* 정보 카드

\* 배경 강조



\---



\## Background



```dart

Background = Color(0xFFF6F8F8)

Surface = Color(0xFFFFFFFF)

```



\---



\## Text



```dart

TextPrimary = Color(0xFF1F2233)

TextSecondary = Color(0xFF8A90A0)

TextDisabled = Color(0xFFC8CDD8)

```



\---



\## Success



```dart

Success = Color(0xFF10C9A7)

```



\---



\## Warning



```dart

Warning = Color(0xFFF5B92F)

```



사용 위치



\* 안심 체크 미완료

\* 주의 필요



\---



\## Error



```dart

Error = Color(0xFFFF6B6B)

```



사용 위치



\* 약 미복용

\* 위험 상태



\---



\## Orange



```dart

Orange = Color(0xFFFF8A26)

```



사용 위치



\* 건강 점수 하락

\* 활동 감소



\---



\# Typography



\## Font Family



```dart

Pretendard

```



Fallback



```dart

Noto Sans KR

```



\---



\## Display



건강 점수



```dart

48 / Bold

```



예시



```text

82점

87점

```



\---



\## Heading



```dart

28 / Bold

```



화면 제목



```text

가족안심

내 건강 리포트

약 복용 관리

```



\---



\## Section Title



```dart

20 / SemiBold

```



예시



```text

오늘 약 복용

우리 가족 건강 점수

```



\---



\## Card Title



```dart

18 / SemiBold

```



\---



\## Body



```dart

14 / Medium

```



\---



\## Caption



```dart

12 / Regular

```



\---



\# Radius System



\## Small



```dart

12

```



입력창



\---



\## Medium



```dart

20

```



카드



\---



\## Large



```dart

28

```



대형 건강 카드



\---



\## Pill



```dart

999

```



버튼

배지

토글



\---



\# Shadow



모든 카드 동일



```dart

Blur = 20

Opacity = 0.06

OffsetY = 4

```



\---



\# Spacing



```dart

xs = 4

sm = 8

md = 16

lg = 24

xl = 32

xxl = 40

```



\---



\# Component System



\## Health Score Card



특징



\* 그라데이션 배경

\* 반원형 게이지

\* 점수 중앙 배치



크기



```dart

Height = 280 \~ 320

Radius = 28

```



\---



\## Medication Card



구성



\* 아이콘

\* 약 이름

\* 복용 시간

\* 상태 아이콘



상태



```text

복용완료

미복용

예정

```



\---



\## Family Status Card



구성



```text

이름

나이

안심 상태

걸음 수

약 복용

기분

```



\---



\## Insight Card



배경



```dart

Primary50

```



Radius



```dart

24

```



내부 카드



```dart

White

Radius 16

```



\---



\## Alert Card



Warning



```dart

Background = #FFF8E7

Border = #F5B92F

```



\---



\## Error Card



```dart

Background = #FFF1F1

Border = #FF6B6B

```



\---



\# Bottom Navigation



탭



```text

홈

가족

걸음

약

설정

```



규칙



활성



```dart

Primary500

```



비활성



```dart

\#A5ACB8

```



\---



\# Charts



\## Line Chart



사용



\* 걸음 수 추이



색상



```dart

Primary500

```



\---



\## Bar Chart



사용



\* 가족 건강 점수



\---



\## Heat Map



사용



\* 월간 활동



\---



\## Calendar



복용 현황



완료



```dart

Primary500

```



미복용



```dart

\#FFD8D8

```



예정



```dart

\#E7EAF0

```



\---



\# Floating Action Button



위치



우측 하단



스타일



```dart

Size = 64

Shape = Circle

Color = Primary500

```



\---



\# Lock Screen Notification



스타일



```dart

Glassmorphism

```



구성



\* 제목

\* 복용 시간

\* 복용 완료 버튼

\* 나중에 알림 버튼



\---



\# Flutter Rules



\## 필수



ThemeData 사용



Color 직접 작성 금지



TextStyle 직접 작성 금지



Spacing 하드코딩 금지



Radius 하드코딩 금지



\---



\## 생성 파일



```text

lib/core/theme/



app\_colors.dart

app\_text\_styles.dart

app\_spacing.dart

app\_radius.dart

app\_theme.dart

```



모든 UI는 위 Theme 파일을 참조해야 한다.



