## ⚡ Git Issue Template

```
## Description
> 작업할 Feature에 대한 설명을 적어주세요.
> ex. json 파일 적용

## Progress
- [ ] todo1
- [ ] todo2
- [ ] todo3

## Expected-Period
> 예상 작업 기간을 적어주세요
> ~ MM/DD(E) ex. ~ 08/14(일)
```

## ⚡ Commit Message Rule
  `<커밋분류>: #<이슈번호> <커밋메세지>`   
```
# ------- 제목 -------
# "커밋타입: #이슈번호 제목"
# 50자 이내 영어
# 제목 끝에 마침표(.) 금지
# 타입의 첫 글자는 반드시 대문자로 작성

# Feat     : 새로운 기능 추가
# Fix      : 버그 수정
# Docs     : README 등 문서 수정
# Design   : UI 디자인 변경
# Style    : 코드의 의미에 영향을 주지 않는 변경 사항
# Comment  : 주석 추가 및 변경
# Refactor : 코드 리팩토링
# Rename   : 파일 혹은 폴더명 수정
# Remove   : 파일 혹은 폴더 삭제
# Resource : 리소스 추가 및 변경 등 코드를 사용하지 않는 리소스에 대한 모든 것
# Chore    : src 또는 테스트 파일을 수정하지 않는 기타 변경사항
# !HOTFIX  : 급하게 치명적인 버그를 고쳐야 하는 경우

# ---- 한 줄 띄우기 ----
# 제목과 본문 사이 한 줄 띄우기

# ------- 본문 -------
# "무엇을", "왜"를 자세하게 설명
# 한 줄당 72자 이내 한/영
# 여러 줄의 메세지는 "-"로 구분

# 예)
# Feat: #42 Add textfield at loginview
#
# - 텍스트 필드의 emailText 변수는 LoginStateHolder와 연결되어 있습니다.
# - 로그인 Password 텍스트 필드가 SecureField로 추가가 필요합니다.

################
```
 </div>

## ⚡ Git Flow
 
 ```
1. 작업 시작 전 Git Issue 생성
  - Issue 탭, 우측 상단 New issue
  - 적합합 template Get started 버튼 클릭
  - 내용 작성 및 Assignees(담당자), Labels 설정, Projects 연결
  - 생성된 이슈 번호 기억하기!

2. Github Projects
  - 칸반보드에서 작업할 이슈 In Progress로 이동

3. 로컬에서 Dev branch 최신화: git pull 받기

4. 작업 브랜치 생성
  - Feat/<작업내용>, Refactor/<작업내용>, Bug/<작업내용>...

5. Add - Commit - Push - Pull Request 과정
  - Commit template(.gitmessage)이용하여 커밋 메세지 작성 
  - ex) Feat: #1 Add git_issue_template
  - 팀별 Pull Request에 관한 내용은 자율로 진행.

6. Github Pull Request 탭에서 merge 및 issue 관리
```
   
 <br>

 </div>
 </details>
