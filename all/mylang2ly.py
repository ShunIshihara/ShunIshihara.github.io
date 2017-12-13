### mylang.txtを読み込み.lyファイルに書き込む
import data                # コードトーンを参照できるように
import sys

### 初期化変数
output_gt = ""                  # .lyに書き込むギター部分の初期化
output_chord = ""
output_lyrics = ""
chord_all = []

def chord_select(chord_name):
    for chord in data.chords:
        if chord["name"] == chord_name:
            return chord["tones"]

# コード行の処理関数
def guitar_create(chord_name,chord_lyrics,chord_process):
    global output_gt
    global output_chord
    global output_lyrics
    output_length = ""          # フレーズの長さを記録
    all_lengths = []            # コード全体の長さ
    chord_tones = chord_select(chord_name)
    chord_tone = chord_tones["1"]
    rhythm_flag = 0
    if chord_process[0] == "\n":     # 入力がなければコードトーンの全音符をoutput_gtに
        output_gt += "<{0}>1 ".format(chord_tone)
        all_lengths.append("1")
    for process_type in chord_process:
        if rhythm_flag == 1:
            if process_type[0] == "s":
                chord_tone_s = chord_tone.split()
                if process_type[1] == "(": # 弦指定が()で入力か宣言されているものから使うか
                    assign_string = process_type.strip("s()\n").split()
                else:
                    assign_strings = data.strings[process_type[1:].strip("\n")]
                    assign_string = assign_strings.split() # 弦指定を分割してassign_stringに入れる 要素数はリズムと同じ
                if len(lengths) != len(assign_string): # エラー処理　もしリズムと弦指定の要素数が合わなければ終了
                    print("リズムと弦指定の数が異なるためプログラムを終了します")
                    sys.exit()
                assign_tone = []                # リズム1つごとのコードトーン
                for assign in assign_string:    # assign_toneにリズム1つごとにコードトーンを入れていく
                    if len(assign) != 1: # もし2文字以上なら
                        mult_strings = list(assign) # 1つのリズムの複数の弦指定を1つずつ入れるリスト
                        mult_tones = ""
                        for num in mult_strings:
                            if num != mult_strings[-1]:
                                mult_tones += "{0} ".format(chord_tone_s[int(num)-1]) # コードトーンを入れる
                            else:
                                mult_tones += "{0}".format(chord_tone_s[int(num)-1]) 
                        assign_tone.append(mult_tones)
                    elif assign == "r":
                        assign_tone.append("r")
                    else: # もし1文字なら
                        assign_tone.append(chord_tone_s[int(assign)-1])
                i = 0
                for length in lengths:          # length変数にlengthsを入れ出力
                    if length.count("r") == 0 and assign_tone[i] != "r": # リズムにも弦指定にも休符がない場合
                        output_gt += "<{0}>{1} ".format(assign_tone[i], length)
                    elif length.count('r'): # リズム側で休符が入っている場合
                        output_gt += "r{0} ".format(length[1])
                    elif assign_tone[i] == "r": # 弦指定側で休符が入っている場合
                        output_gt += "r{0} ".format(length)       
                    i += 1
                rhythm_flag = 0 # rhythm_flag内の処理が終わるので0に戻す
            else:
                for length in lengths:          # length変数にlengthsを入れ出力
                    if length.count('r'):
                        output_gt += "r{0} ".format(length[1])
                    else:
                        output_gt += "<{0}>{1} ".format(chord_tone, length)
                rhythm_flag = 0 # rhythm_flag内の処理が終わるので0に戻す
        if process_type[0] == "h":
            if len(chord_tones) >= 2:
                tone_assign = process_type.strip("h()\n")
                chord_tone = chord_tones[tone_assign] # tonesが複数あるなら指定した番号のtoneを入れる
        elif process_type[0] == "n":                  # "とcdefgabを認める（場合によってはリズム(r)の後にする）
            output_gt += "{0} ".format(process_type.strip("n()\n"))
            output_length += "{0} ".format(process_type.strip("n()\n")) # コード全体の長さを計算するため
        elif process_type[0] == "r": # リズムの場合
            rhythm_flag = 1
            if process_type[1] == ("("):
                chord_rhythm = process_type.strip("r()\n")
                lengths = chord_rhythm.split()   # リズムを分割してlengthsに入れる
                all_lengths += lengths
            else:
                chord_rhythm = process_type[1:].strip("\n")
                lengths = data.rhythms[chord_rhythm].split()
            if process_type.count("\n"):
                for length in lengths:          # length変数にlengthsを入れ出力
                    if length.count('r'):
                        output_gt += "r{0} ".format(length[1])
                    else:
                        output_gt += "<{0}>{1} ".format(chord_tone, length)
    ## output_gtからコード全体の長さを計算する
    # 長さすべてを含むリストの作成
    output_list = output_length.split(" ")
    phrase_length = []
    for output in output_list:
        phrase_length.append(output.strip("cdefgabsf',"))
    all_lengths += phrase_length    
    # 長さの計算(4分単位で歌詞やコードの長さを記述できるようにする)
    length_16 = 0
    length_8 = 0
    length_4 = 0
    length_2 = 0
    length_1 = 0
    for all_length in all_lengths:
        if all_length == "16":
            length_16 += 1
        elif all_length == "8":
            length_8 += 1
        elif all_length == "4":
            length_4 += 1
        elif all_length == "2":
            length_2 += 1
        elif all_length == "1":
            length_1 += 1
    # print(length_1,length_2,length_4,length_8,length_16)
    length_8 += int(length_16 / 2)
    length_16 %= 2
    length_4 += int(length_8 / 2)
    length_8 %= 2
    length_2 += int(length_4 / 2)
    length_4 %= 2
    length_1 += int(length_2 / 2)
    length_2 %= 2
    all_length = []
    all_length.append(length_1)
    all_length.append(length_2)
    all_length.append(length_4)
    all_length.append(length_8)
    all_length.append(length_16)
    print(all_length)
    if all_length[0] >= 4:
        core_length = r"\longa" # 歌詞，コードの1番大きな部分を占める長さ
        length_1 = 0
    elif all_length[0] == 3:
        core_length = r"\breve."
        length_1 = 0
    elif all_length[0] == 2:
        core_length = r"\breve"
        length_1 = 0
    elif all_length[0] == 1:
        if all_length[1] == 0:
            core_length = "1"
        elif all_length[1] == 1:
            core_length = "1."
            length_2 = 0
        length_1 = 0    
    elif all_length[1] == 1:
        if all_length[2] == 0:
            core_length = "2"
        elif all_length[2] == 1:
            core_length = "2."
            length_4 = 0
        length_2 = 0
    elif all_length[2] == 1:
        if all_length[3] == 0:
            core_length = "4"
        elif all_length[3] == 1:
            core_length = "4."
            length_8 = 0
        length_4 = 0
    elif all_length[3] == 1:
        if all_length[4] == 0:
            core_length = "8"
        elif all_length[4] == 1:
            core_length = "8."
            length_16 = 0
        length_8 = 0
    elif all_length[4] == 1:
        core_length = "16"
        length_16 = 0
    # else:                       # いずれ消す
    #     core_length = "1"

    # コードと歌詞表示の長さの代入 (chord)core_length N.C.余りの長さ　と　(歌詞)core_length 全角スペース余りの長さを作る
    # コードを.lyで読める記述に変換する
    chord_ly = chord_name
    if chord_ly.count('.'):     # N.C.をsに変換
        chord_ly = s
    else:
        chord_ly = chord_ly.lower() # すべて小文字に変換
    if chord_ly.count('#'):
        chord_ly = chord_ly.replace('#', 's')
    elif chord_ly.count('♭'):
        chord_ly = chord_ly.replace('♭', 'f')
    if chord_ly.count("m"):
        chord_ly = chord_ly.replace("m", "{0}:m".format(core_length)) 
    elif chord_ly.count("/"):
        chord_ly = chord_ly.replace("/", "{0}:/".format(core_length))
    elif chord_ly.count("add"):
        chord_ly = chord_ly.replace("add", "{0}:add".format(core_length))    
    elif chord_ly.count("7"):
        chord_ly = chord_ly.replace("7", "{0}:7".format(core_length))
    elif chord_ly.count("6"):
        chord_ly = chord_ly.replace("6", "{0}:6".format(core_length))       
    elif chord_ly.count("9"):
        chord_ly = chord_ly.replace("9", "{0}:9".format(core_length))
    elif chord_ly.count("sus4"):
        chord_ly = chord_ly.replace("sus4", "{0}:sus4".format(core_length))
    elif chord_ly.count("aug"):
        chord_ly = chord_ly.replace("aug", "{0}:aug".format(core_length))
    else:
        chord_ly = "{0}{1}".format(chord_ly,core_length)

    output_chord += "{0} ".format(chord_ly) # とN.C.とコードを.lyが読める変換
    if chord_lyrics == "":
        output_lyrics += "　{0} ".format(core_length)     # と全角スペース
    else:
        output_lyrics += "{0}{1} ".format(chord_lyrics,core_length)
    if length_2 == 1:
        output_chord += "s2 "
        output_lyrics += "　2 "
    if length_4 == 1:
        output_chord += "s4 "
        output_lyrics += "　4 "        
    if length_8 == 1:
        output_chord += "s8 "
        output_lyrics += "　8 "
    if length_16 == 1:
        output_chord += "s16 "
        output_lyrics += "　16 "
        
    output_gt += "\n"           # .ly内で1つのコードごとに改行するため
                        
def reg_dic(dic_name,reg_dic):  # dic_nameがリズムと弦指定の場合分け辞書を登録          
    for dic_element in reg_dic:     # reg_dicを1つずつキーと値に分けてリストに入れる
        split_par = dic_element.split("(")
        key = split_par[0]
        value = split_par[1].strip(")\n")
        dict = {key:value}
        if dic_name == "rhythms":
            data.rhythms.update(dict)
        if dic_name == "strings":
            data.strings.update(dict)
            
### main
## 中間言語を1行ずつ読み込む
mylang_f = open("mylang.txt", "r")
mylang_f.close
mylang_lines = mylang_f.readlines()
## 1行ずつ適切な処理を行う
output_capo = ""
output_key = "\key c \major"
meter = "4/4"
tempo = ""
for mylang_line in mylang_lines:
    if mylang_line == "\n":     # 改行だけの行は無視する
        pass
    elif mylang_line.count("%"): # コメント部分を無視する
        mylang_contain_comment = mylang_line.split("%")
        mylang_line = mylang_contain_comment[0]
    ## ヘッダー情報
    elif mylang_line.count("title:"): # タイトル
        line_title = mylang_line.split(":")
        title = line_title[1].rstrip("\n")
        output_title = 'title = "{0}"\n'.format(title)
    elif mylang_line.count("artist:"): # アーティスト
        line_artist = mylang_line.split(":")
        artist = line_artist[1].rstrip("\n")
        output_artist = 'subtitle = "{0}"\n'.format(artist)
    elif mylang_line.count("composer:"): # 作曲者
        line_composer = mylang_line.split(":")
        composer = line_composer[1].rstrip("\n")
        output_composer = 'composer = "{0}"\n'.format(composer)
    elif mylang_line.count("lyrics:"): # 作詞者
        line_lyrics = mylang_line.split(":")
        lyrics = line_lyrics[1].rstrip("\n")
        output_lyric = 'arranger = "{0}"\n'.format(composer)
    elif mylang_line.count("meter:"): # 拍子
        line_meter = mylang_line.split(":")
        meter = line_meter[1].rstrip("\n")
        output_meter = 'time = "{0}"\n'.format(meter)
    elif mylang_line.count("capo:"): # カポ
        line_capo = mylang_line.split(":")
        capo = line_capo[1].rstrip("\n")
        output_capo = 'piece = "Capo:{0}"\n'.format(capo)
    elif mylang_line.count("tempo:"): # カポ
        line_tempo = mylang_line.split(":")
        tempo = line_tempo[1].rstrip("\n")
        output_tempo = r'\tempo 4 = ' + "{0}\n".format(tempo)
    elif mylang_line.count("key:"): # キー
        line_key = mylang_line.split(":")
        key_all = line_key[1].rstrip("\n").split(" ")
        key_tone = key_all[0].lower()
        if key_tone.count('#'):
            key_tone = key_tone.replace('#', 's')
        elif key_tone.count('♭'):
            key_tone = key_tone.replace('♭', 'f')
        if len(key_all) == 1:
            output_key = r'\key {0} \major'.format(key_tone)
        else:
            key_brightness = key_all[1].lower()
            output_key = r'\key {0} \{1}'.format(key_tone,key_brightness)
    ##リズムと弦の登録
    elif mylang_line.count("rhythms:"):
        line_rhythms = mylang_line.split(":")
        reg_rhythms = line_rhythms[1].split(".")
        reg_dic("rhythms",reg_rhythms)
    elif mylang_line.count("strings:"):
        line_strings = mylang_line.split(":")
        reg_strings = line_strings[1].split(".")
        reg_dic("strings",reg_strings)
    ## コード情報の分割
    else:
        chord_part = mylang_line.split(":")
        chord_and_lyrics = chord_part[0].split("(")
        chord_name = chord_and_lyrics[0] # コードネーム
        chord_lyrics = chord_and_lyrics[1].rstrip(")") # コードに対する歌詞
        chord_all.append(chord_part[0]) # コードをすべて入れるためのリスト
        chord_process = chord_part[1].split(".")
        output_guitar = guitar_create(chord_name,chord_lyrics,chord_process) # guitar部分の作成
print("output_lyrics:{0}".format(output_lyrics))
print("output_chord:{0}".format(output_chord))

# print("output_gt:{0}".format(output_gt))
# print(output_title, end="")
# print(output_artist, end="")
# print(output_composer, end="")
# print(output_meter, end="")
# print(output_capo, end="")
# print(output_tempo, end="")
## .lyファイルの読み込みと書き込み
origin_f = open("template2.ly", "r") # 1行ずつ読み込みコピーしoutput_gtを適切な位置に入れコピーを再開し最後に書き出しをする
origin_lines = origin_f.readlines()
change_f = open("template2_change.ly", "w")
for origin_line in origin_lines:
    head_flag = 0
    
    # ヘッダー情報を代入
    if origin_line.count('title = "title"'):
        change_f.write(output_title)
        head_flag = 1
    if origin_line.count('subtitle = "artist"'):
        change_f.write(output_artist)
        head_flag = 1
    if origin_line.count('composer = "composer:"'):
        change_f.write(output_composer)
        head_flag = 1
    if origin_line.count('arranger = "lyrics:"'):
        change_f.write(output_lyric)
        head_flag = 1
    if origin_line.count('piece = "Capo:"'):
        change_f.write(output_capo)
        head_flag = 1 
    # 拍子を入力
    if origin_line.count('time'):
        change_f.write(r"  \time {0}".format(meter))
        change_f.write("\n")
        if tempo != "":
            change_f.write(r"  \tempo 4 = {0}".format(tempo))
            change_f.write("\n")
        
        change_f.write(output_gt) # ギターを入力
        change_f.write("\n")
        head_flag = 1
    # キーを入力
    if origin_line.count('key'):
        change_f.write(output_key)
        change_f.write("\n")
        head_flag = 1
    # 歌詞を入力
    if origin_line.count('lyric = \lyricmode'):
        change_f.write(origin_line)
        change_f.write(output_lyrics)
        head_flag = 1
    # コードを入力
    if origin_line.count('chord = \chordmode'):
        change_f.write(origin_line)
        change_f.write(output_chord)
        head_flag = 1
    if head_flag == 0:
        change_f.write(origin_line) # ヘッダー情報でないなら1行書き込む

    # コードを代入
    # if origin_line == "chord = \chordmode {\n":
    #     change_f.write(output_ch)
    #     change_f.write("\n")  
        
origin_f.close()
change_f.close()
