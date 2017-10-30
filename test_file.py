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

# html.txtからヘッダー情報を取得する
html_r = open("html.txt", "r")
html_lines = html_r.readlines()
header = ""
for html_line in html_lines:
    if html_line.find("strong") > -1: # ヘッダー情報を検索しそれを含む行をheaderに代入
        header = html_line

print(header)
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


## 入力ファイル読み込みと入力データ種類の判別
input_f = open("input.txt", "r")
input_txt = input_f.read()            # テキストファイルをすべて読み込む
input_f.close()
input_data = input_txt.split(",") # 改行で区切りリストにする


## それぞれのデータの処理
# コードトーン
chord_tones = input_data[0]      # リストからコードトーンとリズムそれぞれ代入する
chord_tone = chord_tones.split() # コードトーンを1つずつリストに入れる

# リズム
rhythm = input_data[1]
lengths = rhythm.split()   # リズムを分割してlengthsに入れる

# 弦指定(されてる場合)
assign_flag = 0
if input_data[1][-1] != "\n":   # リズムの最後の文字が改行でなければ弦指定する
    assign_flag = 1
    assign_strings = input_data[2]
    assign_string = assign_strings.split() # 弦指定を分割してassign_stringに入れる 要素数はリズムと同じ
    if len(lengths) != len(assign_string): # エラー処理　もしリズムと弦指定の要素数が合わなければ終了
        print("リズムと弦指定の数が異なるためプログラムを終了します")
        sys.exit()
    assign_tone = []                # リズム1つごとのコードトーン
    tones = 0
    for assign in assign_string:
        if len(assign) != 1: # もし2文字以上なら
            mult_strings = list(assign) # 1つのリズムの複数の弦指定を1つずつ入れるリスト
            print("mult_strings:{0}".format(mult_strings))
            mult_tones = ""      
            for num in mult_strings:
                if num != mult_strings[-1]:
                    mult_tones += "{0} ".format(chord_tone[int(num)-1])
                else:
                    mult_tones += "{0}".format(chord_tone[int(num)-1])
            print("mult_tones:{0}".format(mult_tones))
            assign_tone.append(mult_tones)
        elif assign == "r":
            assign_tone.append("r")
        else: # もし1文字なら
            assign_tone.append(chord_tone[int(assign)-1])
    # assign_tone += chord_tone[int(assign)-1] の場合一文字ずつ代入される
    # print("assign_tone:{0}".format(assign_tone))
    
print(input_data)


## .lyに追加する記述の作成
output = ""
i = 0
# 弦指定なしの場合
if assign_flag == 0:
    for length in lengths:          # length変数にlengthsを入れ出力
        if length.count('r'):
            output += "r{0} ".format(length[1])    
        else:
            output += "<{0}>{1} ".format(chord_tones, length)
        i += 1
# 弦指定ありの場合
elif assign_flag == 1:
    for length in lengths:          # length変数にlengthsを入れ出力
        if input_data[2] != "NULL" and len(length) == 1 and assign_tone[i] != "r":
            output += "<{0}>{1} ".format(assign_tone[i], length)
        elif length.count('r'):
            output += "r{0} ".format(length[1])
        elif assign_tone[i] == "r":
            output += "r{0} ".format(length)       
        else:
            output += "<{0}>{1} ".format(chord_tones, length)
        i += 1

print("output:{0}".format(output))


## .lyファイルの読み込みと書き込み
origin_f = open("template_test.ly", "r") # 1行ずつ読み込みコピーしoutputを適切な位置に入れコピーを再開し最後に書き出しをする
origin_lines = origin_f.readlines()
change_f = open("template_test_change.ly", "w")
for origin_line in origin_lines:
    head_flag = 0
    # ヘッダー情報を代入
    if origin_line.count('title = "title"'):
        change_f.write('  title = "{0}"\n'.format(title))
        head_flag = 1
    if origin_line.count('subtitle = "artist"'):
        change_f.write('  subtitle = "{0}"\n'.format(artist))
        head_flag = 1
    if origin_line.count('composer = "composer:"'):
        change_f.write('  composer = "composer:{0}"\n'.format(composer))
        head_flag = 1
    if origin_line.count('arranger = "lyrics:"'):
        change_f.write('  arranger = "lyrics:{0}"\n'.format(lyrics))
        head_flag = 1       
    if head_flag == 0:
        change_f.write(origin_line) # ヘッダー情報でないなら1行書き込む
    # ギターを代入
    if origin_line == 'guitar = {\n':
        change_f.write(output)
        change_f.write("\n")

origin_f.close()
change_f.close()
