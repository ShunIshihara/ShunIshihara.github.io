### コードトーンとリズム（と弦指定）テキストファイルを読み込み.lyのギターの欄に書き込む

import sys
import urllib.request

## htmlの情報を扱う
# URLからhtmlを取得しテキストファイルに書き込む
url = input("URL:")

html = urllib.request.urlopen(url).read().decode('UTF-8')
html_f = open("html.txt", "w")
html_f.write(html)
html_f.close()
html_r = open("html.txt", "r")
html_lines = html_r.readlines()

# html.txtからヘッダー情報を取得する
header = ""
for html_line in html_lines:
    if html_line.find("strong") > -1: # ヘッダー情報を検索しそれを含む行をheaderに代入
        header = html_line

# html.txtからコード譜情報を取得する
score_data = ""
for html_line in html_lines:    # コード譜の情報のみを選択し1行ずつ代入
    if html_line.find('"atfolhyds"') > -1:
        score_data += html_line

chord_html_bef = score_data.split("<rt>") # コードの部分で分割('コードがないデータ','先頭にコードを含むデータ')
chord_html_aft = []
chord_html_aft2 = []
for chord in chord_html_bef:    # 先頭にコードのあるデータのみを抜粋したリストの作成(後ろにいろいろついてる状態)
    if chord.find("</rt>") > -1:
        chord_html_aft.append(chord)

for chords in chord_html_aft:   # コードのみとその他に分割('コード','その他')
    chord_html_aft2.append(chords.split('</rt>')) # リストの中に2要素のリストが多くある状態
                           
chord_html = []
for chords in chord_html_aft2:  # コードのみの要素を1つずつ抜粋したリストの作成
    chord_html.append(chords[0])
print(chord_html)

## html.txtから歌詞情報を取得する
lyrics_html1 = score_data.split('bold;margin-right:5px;">') # 歌詞の部分で分割
lyrics_html2 = []
lyrics_html3 = []
for lyrics in lyrics_html1:
    if lyrics.find("krijcheug") > -1: # 歌詞の後ろに必ずクラスkri...がある
        lyrics_html2.append(lyrics)

for lyrics in lyrics_html2:
    lyrics_html3.append(lyrics.split('</span><span class="krijcheug"'))

lyrics_html4 = []
lyrics_html_first = []
for lyrics in lyrics_html3:
    if lyrics[0].find("blyodnijb") == -1:
        if lyrics[0].find(r'</p><p class="atfolhyds" style="line-height:75px;font-weight: bold;color: #b22222;width: 90%;">'):
            lyrics_html4.append(lyrics[0].replace('</p><p class="atfolhyds" style="line-height:75px;font-weight: bold;color: #b22222;width: 90%;">','').replace('\u3000','').replace('\ufeff\ufeff','').replace("\n",""))
        elif lyrics[0].find(r'<div id="blyodnijb" onclick="autoscroll()" style="margin-top:25px;margin-bottom:0px;font-size:16px;">﻿'):
            lyrics_html4.append(lyrics[0].replace('<p class="atfolhyds" style="line-height:75px;font-weight: bold;color: #b22222;width: 90%;">','').replace('\u3000','').replace('\ufeff\ufeff','').replace("\n","").replace("</p>","").replace(r'<div id="blyodnijb" onclick="autoscroll()" style="margin-top:25px;margin-bottom:0px;font-size:16px;">﻿',""))
        else:
            lyrics_html4.append(lyrics[0].replace('\u3000','').replace('\ufeff\ufeff','').replace("\n",""))
    elif lyrics[0].find("blyodnijb") > -1 and lyrics[0].find(r'<p class="atfolhyds" style="line-height:75px;font-weight: bold;color: #b22222;width: 90%;">'):
        lyrics_html_first.append(lyrics[0].replace('<p class="atfolhyds" style="line-height:75px;font-weight: bold;color: #b22222;width: 90%;">','').replace('\u3000','').replace('\ufeff\ufeff','').replace("\n","").replace("</p>","").replace(r'<div id="blyodnijb" onclick="autoscroll()" style="margin-top:25px;margin-bottom:0px;font-size:16px;">﻿',""))
        
lyrics_html4[0] = lyrics_html_first[0] + lyrics_html4[0]

lyrics_html_last = lyrics_html1[-1].replace("</p></div>", "").replace('</p><p class="atfolhyds" style="line-height:75px;font-weight: bold;color: #b22222;width: 90%;">','').replace("\n","")
lyrics_html4.append(lyrics_html_last)

lyrics_html5 = []
for lyrics_html in lyrics_html4:
    if lyrics_html.find(r'<div id="blyodnijb" onclick="autoscroll()" style="margin-top:25px;margin-bottom:0px;font-size:16px;">') != -1:
        lyrics_html5.append(lyrics_html.replace(r'<div id="blyodnijb" onclick="autoscroll()" style="margin-top:25px;margin-bottom:0px;font-size:16px;">',''))
    else:
        lyrics_html5.append(lyrics_html)

print(lyrics_html5)
html_r.close()

# タイトルの取得
title_bef = header.split("<strong>")
title_aft = title_bef[1].split("</strong>")
title = title_aft[0]
print(title)

# アーティストの取得
artist_bef = header.split("nbsp;&nbsp;")
artist_aft = artist_bef[1].split("</span>")
artist = artist_aft[0]
print(artist)

# 作詞者の取得
lyrics_bef = header.split("作詞 : ")
lyrics_aft = lyrics_bef[1].split("/作曲")
lyrics = lyrics_aft[0]
print(lyrics)

# 作曲者の取得
composer_bef = header.split("作曲 : ")
composer_aft = composer_bef[1].split("</p>")
composer = composer_aft[0]
print(composer)

## htmlのデータを中間言語に記述
mylang_f = open("mylang.txt", "w")
# ヘッダー情報
mylang_f.write("title:{0}\n".format(title))
mylang_f.write("artist:{0}\n".format(artist))
mylang_f.write("composer:{0}\n".format(composer))
mylang_f.write("lyrics:{0}\n".format(lyrics))
mylang_f.write("key:\n")

# コードと歌詞情報
i = 0
for chord in chord_html:
    mylang_f.write(chord + "({0})".format(lyrics_html5[i]) + ":\n")
    i += 1
