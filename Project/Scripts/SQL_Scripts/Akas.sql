/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [Id]
      ,[titleId]
      ,[ordering]
      ,[title]
      ,[region]
      ,[language]
      ,[types]
      ,[attributes]
      ,[isOriginalTitle]
  FROM [AMDB].[tmp].[tmpAkas]
  --WHERE isOriginalTitle = 1


SELECT COUNT(DISTINCT titleId) FROM [AMDB].[tmp].[tmpAkas] --6153560
SELECT COUNT(*) FROM [AMDB].[tmp].[tmpAkas] WHERE isOriginalTitle = '1' --1836818
SELECT COUNT(*) FROM [AMDB].[tmp].[tmpAkas] WHERE attributes = 'literal title' --10730
SELECT COUNT(*) FROM [AMDB].[tmp].[tmpAkas] WHERE [types] = 'original' --1836819


SELECT DISTINCT region FROM  [AMDB].[tmp].[tmpAkas]
/*
ES
PT
AU
NL
IN
XAS
EC
CM
GY
ZM
VU
EH
HR
XYU
GB
XWW
FI
MX
RS
UY
PH
EG
AW
LR
XAU
AS
DM
SB
FM
CW
ZA
XEU
CU
CR
ML
SD
NI
QA
RW
PG
VC
GW
TL
VN
SK
HK
TH
KR
MK
BA
NE
MD
TM
GN
MN
RE
VG
FJ
CF
TV
DK
GR
AR
IR
IM
AN
KY
BB
DJ
AI
MQ
BN
CSHH
PE
BD
AL
TT
GA
PS
CSXX
AD
ME
LA
GF
PW
ST
SUHH
SE
CZ
BUMM
BJ
DZ
BY
ZW
MU
MG
TO
OM
MR
SO
GQ
CA
SG
PY
DO
XSA
ET
AG
BS
MV
UG
GI
XSI
BM
XNA
JE
\N
SI
NO
LT
JM
ID
LU
SM
CD
CY
GU
BW
ZRCD
CK
DE
IL
UA
DDDE
XPI
AM
NP
KG
VDVN
TZ
HT
SR
LS
NC
MP
NU
BG
BE
CH
NZ
PA
GE
BF
LK
CI
XKV
BH
KW
BT
FO
ER
VI
AQ
WS
BR
IS
TW
IE
BO
XKO
PR
CG
GH
IQ
KH
MT
SA
CV
KN
NR
HU
IT
PL
TR
CL
MY
PK
AE
GT
TD
LY
MM
HN
MH
US
JP
XWG
AT
YUCS
AZ
UZ
MA
KZ
AF
TJ
MZ
SH
LC
KM
FR
RU
CN
CO
GL
LV
NG
TN
LI
AO
LB
SV
TG
KP
BZ
YE
GP
MO
SZ
SC
VA
GM
MS
TC
GD
RO
VE
EE
MC
SN
SY
KE
NA
SL
BI
JO
PF
KI
MW
*/

SELECT DISTINCT [language] FROM  [AMDB].[tmp].[tmpAkas]
/*
hr
fi
kk
ko
sq
\N
en
id
gu
cy
lt
no
sr
de
te
tk
am
bg
cs
el
be
pa
yi
zu
vi
jv
he
yue
qbp
kn
zh
is
wo
br
tr
qbn
it
pl
hu
my
iu
ja
uz
az
af
hy
lo
qac
sv
fr
ru
lv
ms
gl
gd
da
tg
tn
sl
hi
xh
ro
ku
es
nl
ur
pt
rm
ar
bn
qbo
qal
ky
prs
la
ga
st
ps
haw
uk
fa
mr
myv
cmn
ca
ka
bs
et
fro
su
roa
ml
tl
ta
mi
sd
cr
sk
mk
th
eu
gsw
rn
mn
ne
*/

SELECT DISTINCT [types] FROM  [AMDB].[tmp].[tmpAkas]
/*
festivalimdbDisplay
alternativedvd
video
dvdimdbDisplay
alternativeworking
alternativevideo
original
tv
working
dvd
festival
imdbDisplayworking
videoworking
imdbDisplaytv
festivalworking
tvvideo
dvdvideo
alternativetv
imdbDisplayvideo
tvworking
imdbDisplay
\N
alternative
alternativefestival
*/

SELECT DISTINCT [attributes] FROM  [AMDB].[tmp].[tmpAkas]
/*
game box title
eleventh season title
reissue titleshort version
original pilot title
PC version
twentythird season title
twentysixth season title
armed forces circuit title
approximation of original mirrored title
third part title
first episodes title
eighteenth season title
teaser title
Yiddish dubbed
twentyfifth season title
daytime version title
second segment title
twentieth season title
incorrect title
thirtyfifth season title
DVD box title
short version
Berlin film festival title
second copyright title
first segment title
Los Angeles premiere title
racier versionreissue title
Los Angeles premi?re title
cut version
promotional abbreviation
first season title
director's cut
MIFED title
expansion title
title for episodes with guest hosts
R-rated version
thirtieth season title
twentysecond season title
longer versionrerun title
alternative transliteration
video box title
literal translation of working title
summer title
tenth season title
correct transliteration
8mm release titlesecond part title
twentyfourth season title
closing credits titlepre-release title
orthographically correct titlevideo box title
literal English title
alternative spelling
informal title
censored version
TV listings title
segment title
fifth season title
sixth season title
thirtyfirst season title
thirtyseventh season title
silent version
informal literal title
cable TV title
review title
second part title
video catalogue title
soft porn version
third segment title
Yiddish dubbedreissue title
thirtyeighth season title
added framing sequences and narration in Yiddishreissue title
original subtitled version
copyright title
short title
orthographically correct title
eighth season title
fake working title
new syndication title
unauthorized video title
cut versionreissue title
rumored
twelfth season title
dubbed versionrecut version
twentyninth season title
late Sunday edition
literal French title
rerun title
original script title
16mm release title
YIVO translation
anthology series
first episode title
Cannes festival title
Venice film festival title
informal titleliteral title
thirtythird season title
transliterated title
theatrical title
recut version
first part title
3-D version
modern translation
ninth season title
twentyseventh season title
nineteenth season title
racier version
sixteenth season title
recut versionreissue title
first three episodes title
third and fourth season title
16mm rental title
Hakka dialect title
American Mutoscope & Biograph catalog title
long title
informal English title
informal short title
weekend title
trailer title
bootleg title
longer version
videogame episode
redubbed comic version
cut versionvideo box title
GameCube version
thirtyninth season title
fortieth season title
first four episodes title
\N
dubbed version
reissue title
informal literal English title
8mm release title
second season title
X-rated version
video CD title
Pay-TV title
fifteenth season title
seventeenth season title
IMAX versionpromotional title
poster title
DVD menu title
informal alternative title
uncensored intended title
fourth part title
fourth season title
LD title
thirteenth season title
English translation of working title
poster titlevideo box title
fifth part title
cable TV titlecut version
X-rated versionbootleg title
Locarno film festival title
complete title
restored version
promotional title
bowdlerized title
closing credits title
seventh season title
POLartvideo box title
thirtyfourth season title
Bable dialect title
series title
premiere title
long new title
third season title
IMAX version
fourteenth season title
premi?re title
twentyeighth season title
non-modified Hepburn romanization
3-D video title
YIVO translationreissue title
8mm release titleshort version
first two episodes title
literal title
new title
subtitle
pre-release title
last season title
syndication title
english transliteration
thirtysecond season title
POLart
twentyfirst season title
Bilbao festival title
thirtysixth season title
promotional titlethirteenth season title
fourth season titlerecut version
*/