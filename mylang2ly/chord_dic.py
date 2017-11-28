def chord_select(chord_name):
    chords = [
        {"name":"C","tones":{"1":r"c\5 e\4 g\3 c'\2 e'\1","2":r"c\5 g\4 c'\3 e'\2 g'\1"}},
        {"name":"G","tones":{"1":r"g,\6 b,\5 d\4 g\3 b\2 g'\1"}},
        {"name":"G7","tones":{"1":r"g,\6 b,\5 d\4 g\3 b\2 f'\1"}},
        {"name":"F","tones":{"1":r"f,\6 c\5 f\4 a\3 c'\2 f'\1"}}
    ]
    for chord in chords:
        if chord["name"] == chord_name:
            return chord["tones"]

