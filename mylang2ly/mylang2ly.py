### mylang.txtを読み込み.lyファイルに書き込む
import data                # コードトーンを参照できるように
import sys

### 初期化変数
output_gt = ""                  # .lyに書き込むギター部分の初期化
chord_all = []

def chord_select(chord_name):
    for chord in data.chords:
        if chord["name"] == chord_name:
            return chord["tones"]

# コード行の処理関数
def guitar_create(chord_name,chord_process):
    global output_gt
    chord_tones = chord_select(chord_name)
    chord_tone = chord_tones["1"]
    for process_type in chord_process:
        assign_flag = 0         # 指弾きがあるかどうかのフラグ
        note_flag = 0
        if process_type[0] == "h":
            if len(chord_tones) >= 2:
                tone_assign = process_type.strip("h()")
                chord_tone = chord_tones[tone_assign] # tonesが複数あるなら指定した番号のtoneを入れる
        elif process_type[0] == "n":
            note_flag = 1
            output_gt_note = "{0} ".format(process_type.strip("n()\n"))
        elif process_type[0] == "r": # リズムの場合
            if process_type[1] == ("("):
                chord_rhythm = process_type.strip("r()\n")
                lengths = chord_rhythm.split()   # リズムを分割してlengthsに入れる
            else:
                chord_rhythm = process_type[1:].strip("\n")
                lengths = data.rhythms[chord_rhythm].split()
        elif process_type[0] == "s": # 弦指定の場合
            assign_flag = 1
            chord_tone = chord_tone.split()
            if process_type[1] == "(":
                assign_strings = process_type.strip("s()\n")
            else:
                assign_strings = data.strings[process_type[1:].strip("\n")]
            assign_string = assign_strings.split() # 弦指定を分割してassign_stringに入れる 要素数はリズムと同じ
            if len(lengths) != len(assign_string): # エラー処理　もしリズムと弦指定の要素数が合わなければ終了
                print("リズムと弦指定の数が異なるためプログラムを終了します")
                sys.exit()
            assign_tone = []                # リズム1つごとのコードトーン
            for assign in assign_string:
                if len(assign) != 1: # もし2文字以上なら
                    mult_strings = list(assign) # 1つのリズムの複数の弦指定を1つずつ入れるリスト
                    mult_tones = ""
                    for num in mult_strings:
                        if num != mult_strings[-1]:
                            mult_tones += "{0} ".format(chord_tone[int(num)-1]) # コードトーンを入れる
                        else:
                            mult_tones += "{0}".format(chord_tone[int(num)-1]) 
                    assign_tone.append(mult_tones)
                elif assign == "r":
                    assign_tone.append("r")
                else: # もし1文字なら
                    assign_tone.append(chord_tone[int(assign)-1])
            
    ## .lyに追加する記述の作成
    # global output_gt
    i = 0
    # 弦指定なしの場合
    if assign_flag == 0:
        if note_flag == 1:
            # output_gt += output_gt_note
            pass
        else:
            for length in lengths:          # length変数にlengthsを入れ出力
                if length.count('r'):
                    output_gt += "r{0} ".format(length[1])
                else:
                    output_gt += "<{0}>{1} ".format(chord_tone, length)
                i += 1
    # 弦指定ありの場合
    elif assign_flag == 1:
        for length in lengths:          # length変数にlengthsを入れ出力
            if len(length) == 1 and assign_tone[i] != "r":
                output_gt += "<{0}>{1} ".format(assign_tone[i], length)
            elif length.count('r'):
                output_gt += "r{0} ".format(length[1])
            elif assign_tone[i] == "r":
                output_gt += "r{0} ".format(length)       
            else:
                output_gt += "<{0}>{1} ".format(chord_tones, length)
            i += 1

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
        print(output_title, end="")
    elif mylang_line.count("artist:"): # アーティスト
        line_artist = mylang_line.split(":")
        artist = line_artist[1].rstrip("\n")
        output_artist = 'subtitle = "{0}"\n'.format(artist)
        print(output_artist, end="")
    elif mylang_line.count("composer:"): # 作曲者
        line_composer = mylang_line.split(":")
        composer = line_composer[1].rstrip("\n")
        output_composer = 'composer = "{0}"\n'.format(composer)
        print(output_composer, end="")
    elif mylang_line.count("lyrics:"): # 作詞者
        line_lyrics = mylang_line.split(":")
        lyrics = line_lyrics[1].rstrip("\n")
        output_lyrics = 'arranger = "{0}"\n'.format(composer)
        print(output_lyrics, end="")
    elif mylang_line.count("meter:"): # 拍子
        line_meter = mylang_line.split(":")
        meter = line_meter[1].rstrip("\n")
        output_meter = 'time = "{0}"\n'.format(meter)
        print(output_meter, end="")
    elif mylang_line.count("capo:"): # カポ
        line_capo = mylang_line.split(":")
        capo = line_capo[1].rstrip("\n")
        output_capo = 'piece = "Capo:{0}"\n'.format(capo)
        print(output_capo, end="")
    elif mylang_line.count("tempo:"): # カポ
        line_tempo = mylang_line.split(":")
        tempo = line_tempo[1].rstrip("\n")
        output_tempo = r'\tempo 4 = ' + "{0}\n".format(tempo)
        print(output_tempo, end="")
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
        chord_name = chord_part[0]
        chord_all.append(chord_part[0]) # コードをすべて入れるためのリスト
        chord_process = chord_part[1].split(".")
        output_guitar = guitar_create(chord_name,chord_process) # guitar部分の作成
# print("output_gt:{0}".format(output_gt))

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
        change_f.write(output_lyrics)
        head_flag = 1
    if origin_line.count('piece = "Capo:"'):
        change_f.write(output_capo)
        head_flag = 1 
    # 拍子を入力
    if origin_line.count('time'):
        change_f.write(r"  \time {0}".format(meter))
        change_f.write("\n")
        change_f.write(r"  \tempo 4 = {0}".format(tempo))
        change_f.write("\n")
        
        change_f.write(output_gt) # ギターを入力
        change_f.write("\n")
        head_flag = 1
    if head_flag == 0:
        change_f.write(origin_line) # ヘッダー情報でないなら1行書き込む

    # コードを代入
    # if origin_line == "chord = \chordmode {\n":
    #     change_f.write(output_ch)
    #     change_f.write("\n")  
        
origin_f.close()
change_f.close()
