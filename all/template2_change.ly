%%% 弾き語り用TAB譜のテンプレート2

\language "english"		% 言語設定(英語)
\include "predefined-guitar-fretboards.ly"
\version "2.18.2"

%%ヘッダー
\header {                       
title = "小さな恋のうた"
subtitle = "MONGOL800"
composer = "MONGOL800"
arranger = "MONGOL800"
}

%% ボーカル
vocal =  \relative c' {

}

%% 歌詞
lyric = \lyricmode {
広い宇宙1 の数1 ある一1 つ青1 い地球1 の広1 い世界1 で小1 さな恋1 の思1 いは届1 く小1 さな島1 のあな1 たのもと1 へ1 あな1 たと出会1 い時1 は流れ1 る思1 いを込め1 た手1 紙もふえ1 るいつ1 しか二1 人互1 いに響1 く時1 に激し1 く時1 に切な1 く響1 くは遠1 く遥1 か彼方1 へやさ1 しい歌1 は世1 界を変え1 る\breve ほ\breve らあ1 なたにとっ1 て1 大事な1 人ほどす1 ぐそ1 ばにいる1 のた1 だあ1 なたにだ1 け1 届いて欲1 しい1 響け1 恋の1 歌ほ1 ら1 　1 　1 ほ1 ら1 　1 　1 ほ1 ら1 　1 　1 　1 響け1 恋の1 歌あなたは気づ1 く二1 人は歩1 く暗1 い道で1 も日々1 照らす1 月握1 りしめた1 手離1 すことな1 く思1 いは強1 く永1 遠誓1 う永1 遠の1 淵きっ1 と僕は1 言う思1 い変わら1 ず同1 じ言葉1 をそれ1 でも足り1 ず1 涙にかわ1 り1 喜びにな1 り言1 葉にでき1 ずただ1 抱きしめ1 るただ1 抱きしめ1 る1 ほ1 らあ1 なたにとっ1 て1 大事な1 人ほどす1 ぐそ1 ばにいる1 のた1 だあ1 なたにだ1 け1 届いて欲1 しい1 響け1 恋の1 歌ほ1 ら1 　1 　1 ほ1 ら1 　1 　1 ほ1 ら1 　1 　1 　1 響け1 恋の1 歌夢1 ならば覚めない1 で夢1 ならば覚めない1 であな1 たと過ご1 した時1 永1 遠1 の星1 とな1 るほ1 らあ1 なたにとっ1 て1 大事な1 人ほどす1 ぐそ1 ばにいる1 のた1 だあ1 なたにだ1 け1 届いて欲1 しい1 響け1 恋の1 歌ほ1 らあ1 なたにとっ1 て1 大事な1 人ほどす1 ぐそ1 ばにいる1 のた1 だあ1 なたにだ1 け1 届いて欲1 しい1 響け1 恋の1 歌ほ1 ら1 　1 　1 ほ1 ら1 　1 　1 ほ1 ら1 　1 　1 　1 響け1 恋の1 歌1 
}

\storePredefinedDiagram #default-fret-table
                        \chordmode { c'' }
                        #guitar-tuning
                        #(offset-fret 2 (chord-shape 'bes guitar-tuning))
\storePredefinedDiagram #default-fret-table
                        \chordmode { d'' }
                        #guitar-tuning
                        #(offset-fret 4 (chord-shape 'bes guitar-tuning))

%% コードとダイアグラム用
chord = \chordmode {
b1 ds1:m e1 b1 e1 b1 fs1 gs1:m b1 ds1:m e1 b1 e1 b1 fs1 gs1:m fs1 b1 ds1:m e1 b1 e1 b1 fs1 gs1:m b1 ds1:m e1 b1 e1 b1 fs1 gs1:m ds1:m e1 fs1 gs1:m ds1:m e1 fs1 b\breve fs\breve e1 fs1 gs1:m ds1:m e1 b1 fs1 b1 e1 fs1 gs1:m ds1:m e1 b1 fs1 b1 e1 fs1 gs1:m ds1:m e1 fs1 gs1:m ds1:m e1 fs1 gs1:m ds1:m e1 fs1 b1 ds1:m e1 b1 e1 b1 fs1 gs1:m b1 ds1:m e1 b1 e1 b1 fs1 gs1:m b1 ds1:m e1 b1 e1 b1 fs1 gs1:m ds1:m e1 fs1 gs1:m ds1:m e1 fs1 b1 fs1 b1 fs1 b1 fs1 e1 fs1 gs1:m ds1:m e1 b1 fs1 b1 e1 fs1 gs1:m ds1:m e1 b1 fs1 b1 e1 fs1 gs1:m ds1:m e1 fs1 gs1:m ds1:m e1 fs1 gs1:m ds1:m e1 fs1 b1 e1 b1 e1 b1 e1 fs1 gs1:m ds1:m e1 b1 fs1 e1 fs1 gs1:m ds1:m e1 b1 fs1 b1 e1 fs1 gs1:m ds1:m e1 b1 fs1 b1 e1 fs1 gs1:m ds1:m e1 b1 fs1 b1 e1 fs1 gs1:m ds1:m e1 b1 fs1 b1 e1 fs1 gs1:m ds1:m e1 fs1 gs1:m ds1:m e1 fs1 gs1:m ds1:m e1 fs1 b1 
}

%% ギター(コードを表示したい音符に^""でできる)
guitar = {
\key b \major
  \time 4/4
<b,\6 fs\5>4 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 
<ds\5 as\4>4 <ds\5 as\4>8 <ds\5 as\4>8 <ds\5 as\4>8 <ds\5 as\4>8 <ds\5 as\4>8 <ds\5 as\4>8 
<e\5 b\4>4 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 
<b,\6 fs\5>4 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 
<e\5 b\4>4 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 
<b,\6 fs\5>4 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 
<fs\5 cs'\4>4 <fs\5 cs'\4>8 <fs\5 cs'\4>8 <fs\5 cs'\4>8 <fs\5 cs'\4>8 <fs\5 cs'\4>8 <fs\5 cs'\4>8 
<gs\5 ds'\4>4 <gs\5 ds'\4>8 <gs\5 ds'\4>8 <gs\5 ds'\4>8 <gs\5 ds'\4>8 <gs\5 ds'\4>8 <gs\5 ds'\4>8 
<b,\6 fs\5>4 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 
<ds\5 as\4>4 <ds\5 as\4>8 <ds\5 as\4>8 <ds\5 as\4>8 <ds\5 as\4>8 <ds\5 as\4>8 <ds\5 as\4>8 
<e\5 b\4>4 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 
<b,\6 fs\5>4 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 
<e\5 b\4>4 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 
<b,\6 fs\5>4 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 
<fs\5 cs'\4>4 <fs\5 cs'\4>8 <fs\5 cs'\4>8 <fs\5 cs'\4>8 <fs\5 cs'\4>8 <fs\5 cs'\4>8 <fs\5 cs'\4>8 
<gs\5 ds'\4>4 r4 r2 
<fs\5 cs'\4>2 r2 
<b,\6 fs\5>4 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 
<ds\5 as\4>4 <ds\5 as\4>8 <ds\5 as\4>8 <ds\5 as\4>8 <ds\5 as\4>8 <ds\5 as\4>8 <ds\5 as\4>8 
<e\5 b\4>4 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 
<b,\6 fs\5>4 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 
<e\5 b\4>4 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 
<b,\6 fs\5>4 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 
<fs\5 cs'\4>4 <fs\5 cs'\4>8 <fs\5 cs'\4>8 <fs\5 cs'\4>8 <fs\5 cs'\4>8 <fs\5 cs'\4>8 <fs\5 cs'\4>8 
<gs\5 ds'\4>4 <gs\5 ds'\4>8 <gs\5 ds'\4>8 <gs\5 ds'\4>8 <gs\5 ds'\4>8 <gs\5 ds'\4>8 <gs\5 ds'\4>8 
<b,\6 fs\5>4 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 
<ds\5 as\4>4 <ds\5 as\4>8 <ds\5 as\4>8 <ds\5 as\4>8 <ds\5 as\4>8 <ds\5 as\4>8 <ds\5 as\4>8 
<e\5 b\4>4 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 
<b,\6 fs\5>4 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 
<e\5 b\4>4 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 
<b,\6 fs\5>4 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 
<fs\5 cs'\4>4 <fs\5 cs'\4>8 <fs\5 cs'\4>8 <fs\5 cs'\4>8 <fs\5 cs'\4>8 <fs\5 cs'\4>8 <fs\5 cs'\4>8 
<gs\5 ds'\4>4 <gs\5 ds'\4>8 <gs\5 ds'\4>8 <gs\5 ds'\4>8 <gs\5 ds'\4>8 <gs\5 ds'\4>8 <gs\5 ds'\4>8 
<ds\5 as\4>4 <ds\5 as\4>8 <ds\5 as\4>8 <ds\5 as\4>8 <ds\5 as\4>8 <ds\5 as\4>8 <ds\5 as\4>8 
<e\5 b\4>4 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 
<fs\5 cs'\4>4 <fs\5 cs'\4>8 <fs\5 cs'\4>8 <fs\5 cs'\4>8 <fs\5 cs'\4>8 <fs\5 cs'\4>8 <fs\5 cs'\4>8 
<gs\5 ds'\4>4 <gs\5 ds'\4>8 <gs\5 ds'\4>8 <gs\5 ds'\4>8 <gs\5 ds'\4>8 <gs\5 ds'\4>8 <gs\5 ds'\4>8 
<ds\5 as\4>4 <ds\5 as\4>8 <ds\5 as\4>8 <ds\5 as\4>8 <ds\5 as\4>8 <ds\5 as\4>8 <ds\5 as\4>8 
<e\5 b\4>4 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 
<fs\5 cs'\4>4 <fs\5 cs'\4>8 <fs\5 cs'\4>8 <fs\5 cs'\4>8 <fs\5 cs'\4>8 <fs\5 cs'\4>8 <fs\5 cs'\4>8 
<b,\6 fs\5>4 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>4 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 
<fs\5 cs'\4>4 <fs\5 cs'\4>8 <fs\5 cs'\4>8 <fs\5 cs'\4>8 <fs\5 cs'\4>8 <fs\5 cs'\4>8 <fs\5 cs'\4>8 <fs\5 cs'\4>4 r4 r2 
<e\5 b\4>4 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 
<fs\5 cs'\4>4 <fs\5 cs'\4>8 <fs\5 cs'\4>8 <fs\5 cs'\4>8 <fs\5 cs'\4>8 <fs\5 cs'\4>8 <fs\5 cs'\4>8 
<gs\5 ds'\4>4 <gs\5 ds'\4>8 <gs\5 ds'\4>8 <gs\5 ds'\4>8 <gs\5 ds'\4>8 <gs\5 ds'\4>8 <gs\5 ds'\4>8 
<ds\5 as\4>4 <ds\5 as\4>8 <ds\5 as\4>8 <ds\5 as\4>8 <ds\5 as\4>8 <ds\5 as\4>8 <ds\5 as\4>8 
<e\5 b\4>4 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 
<b,\6 fs\5>4 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 
<fs\5 cs'\4>4 <fs\5 cs'\4>8 <fs\5 cs'\4>8 <fs\5 cs'\4>8 <fs\5 cs'\4>8 <fs\5 cs'\4>8 <fs\5 cs'\4>8 
<b,\6 fs\5>4 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 
<e\5 b\4>4 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 
<fs\5 cs'\4>4 <fs\5 cs'\4>8 <fs\5 cs'\4>8 <fs\5 cs'\4>8 <fs\5 cs'\4>8 <fs\5 cs'\4>8 <fs\5 cs'\4>8 
<gs\5 ds'\4>4 <gs\5 ds'\4>8 <gs\5 ds'\4>8 <gs\5 ds'\4>8 <gs\5 ds'\4>8 <gs\5 ds'\4>8 <gs\5 ds'\4>8 
<ds\5 as\4>4 <ds\5 as\4>8 <ds\5 as\4>8 <ds\5 as\4>8 <ds\5 as\4>8 <ds\5 as\4>8 <ds\5 as\4>8 
<e\5 b\4>4 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 
<b,\6 fs\5>4 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 
<fs\5 cs'\4>4 <fs\5 cs'\4>8 <fs\5 cs'\4>8 <fs\5 cs'\4>8 <fs\5 cs'\4>8 <fs\5 cs'\4>8 <fs\5 cs'\4>8 
<b,\6 fs\5>4 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 <b,\6 fs\5>8 
<e\5 b\4>4 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 
<fs\5 cs'\4>4 <fs\5 cs'\4>8 <fs\5 cs'\4>8 <fs\5 cs'\4>8 <fs\5 cs'\4>8 <fs\5 cs'\4>8 <fs\5 cs'\4>8 
<gs\5 ds'\4>4 <gs\5 ds'\4>8 <gs\5 ds'\4>8 <gs\5 ds'\4>8 <gs\5 ds'\4>8 <gs\5 ds'\4>8 <gs\5 ds'\4>8 
<ds\5 as\4>4 <ds\5 as\4>8 <ds\5 as\4>8 <ds\5 as\4>8 <ds\5 as\4>8 <ds\5 as\4>8 <ds\5 as\4>8 
<e\5 b\4>4 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 
<fs\5 cs'\4>4 <fs\5 cs'\4>8 <fs\5 cs'\4>8 <fs\5 cs'\4>8 <fs\5 cs'\4>8 <fs\5 cs'\4>8 <fs\5 cs'\4>8 
<gs\5 ds'\4>4 <gs\5 ds'\4>8 <gs\5 ds'\4>8 <gs\5 ds'\4>8 <gs\5 ds'\4>8 <gs\5 ds'\4>8 <gs\5 ds'\4>8 
<ds\5 as\4>4 <ds\5 as\4>8 <ds\5 as\4>8 <ds\5 as\4>8 <ds\5 as\4>8 <ds\5 as\4>8 <ds\5 as\4>8 
<e\5 b\4>4 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 
<fs\5 cs'\4>4 <fs\5 cs'\4>8 <fs\5 cs'\4>8 <fs\5 cs'\4>8 <fs\5 cs'\4>8 <fs\5 cs'\4>8 <fs\5 cs'\4>8 
<gs\5 ds'\4>4 <gs\5 ds'\4>8 <gs\5 ds'\4>8 <gs\5 ds'\4>8 <gs\5 ds'\4>8 <gs\5 ds'\4>8 <gs\5 ds'\4>8 
<ds\5 as\4>4 <ds\5 as\4>8 <ds\5 as\4>8 <ds\5 as\4>8 <ds\5 as\4>8 <ds\5 as\4>8 <ds\5 as\4>8 
<e\5 b\4>4 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 <e\5 b\4>8 
<fs\5 cs'\4>4 r4 r2 
<b,\6 fs\5 b\4 ds'\3 fs'\2 b'\1>1 
<ds\5 as\4 ds'\3 fs'\2 as'\1>1 
<e\5 b\4 e'\3 gs'\2 b'\1>1 
<b,\6 fs\5 b\4 ds'\3 fs'\2 b'\1>1 
<e\5 b\4 e'\3 gs'\2 b'\1>1 
<b,\6 fs\5 b\4 ds'\3 fs'\2 b'\1>1 
<fs\5 cs'\4 fs'\3 as'\2 cs''\1>1 
<gs\5 ds'\4 gs'\3 b'\2 ds''\1>1 
<b,\6 fs\5 b\4 ds'\3 fs'\2 b'\1>1 
<ds\5 as\4 ds'\3 fs'\2 as'\1>1 
<e\5 b\4 e'\3 gs'\2 b'\1>1 
<b,\6 fs\5 b\4 ds'\3 fs'\2 b'\1>1 
<e\5 b\4 e'\3 gs'\2 b'\1>1 
<b,\6 fs\5 b\4 ds'\3 fs'\2 b'\1>1 
<fs\5 cs'\4 fs'\3 as'\2 cs''\1>1 
<gs\5 ds'\4 gs'\3 b'\2 ds''\1>1 
<b,\6 fs\5 b\4 ds'\3 fs'\2 b'\1>1 
<ds\5 as\4 ds'\3 fs'\2 as'\1>1 
<e\5 b\4 e'\3 gs'\2 b'\1>1 
<b,\6 fs\5 b\4 ds'\3 fs'\2 b'\1>1 
<e\5 b\4 e'\3 gs'\2 b'\1>1 
<b,\6 fs\5 b\4 ds'\3 fs'\2 b'\1>1 
<fs\5 cs'\4 fs'\3 as'\2 cs''\1>1 
<gs\5 ds'\4 gs'\3 b'\2 ds''\1>1 
<ds\5 as\4 ds'\3 fs'\2 as'\1>1 
<e\5 b\4 e'\3 gs'\2 b'\1>1 
<fs\5 cs'\4 fs'\3 as'\2 cs''\1>1 
<gs\5 ds'\4 gs'\3 b'\2 ds''\1>1 
<ds\5 as\4 ds'\3 fs'\2 as'\1>1 
<e\5 b\4 e'\3 gs'\2 b'\1>1 
<fs\5 cs'\4 fs'\3 as'\2 cs''\1>1 
<b,\6 fs\5 b\4 ds'\3 fs'\2 b'\1>1 
<fs\5 cs'\4 fs'\3 as'\2 cs''\1>1 
<b,\6 fs\5 b\4 ds'\3 fs'\2 b'\1>1 
<fs\5 cs'\4 fs'\3 as'\2 cs''\1>1 
<b,\6 fs\5 b\4 ds'\3 fs'\2 b'\1>1 
<fs\5 cs'\4 fs'\3 as'\2 cs''\1>1 
<e\5 b\4 e'\3 gs'\2 b'\1>1 
<fs\5 cs'\4 fs'\3 as'\2 cs''\1>1 
<gs\5 ds'\4 gs'\3 b'\2 ds''\1>1 
<ds\5 as\4 ds'\3 fs'\2 as'\1>1 
<e\5 b\4 e'\3 gs'\2 b'\1>1 
<b,\6 fs\5 b\4 ds'\3 fs'\2 b'\1>1 
<fs\5 cs'\4 fs'\3 as'\2 cs''\1>1 
<b,\6 fs\5 b\4 ds'\3 fs'\2 b'\1>1 
<e\5 b\4 e'\3 gs'\2 b'\1>1 
<fs\5 cs'\4 fs'\3 as'\2 cs''\1>1 
<gs\5 ds'\4 gs'\3 b'\2 ds''\1>1 
<ds\5 as\4 ds'\3 fs'\2 as'\1>1 
<e\5 b\4 e'\3 gs'\2 b'\1>1 
<b,\6 fs\5 b\4 ds'\3 fs'\2 b'\1>1 
<fs\5 cs'\4 fs'\3 as'\2 cs''\1>1 
<b,\6 fs\5 b\4 ds'\3 fs'\2 b'\1>1 
<e\5 b\4 e'\3 gs'\2 b'\1>1 
<fs\5 cs'\4 fs'\3 as'\2 cs''\1>1 
<gs\5 ds'\4 gs'\3 b'\2 ds''\1>1 
<ds\5 as\4 ds'\3 fs'\2 as'\1>1 
<e\5 b\4 e'\3 gs'\2 b'\1>1 
<fs\5 cs'\4 fs'\3 as'\2 cs''\1>1 
<gs\5 ds'\4 gs'\3 b'\2 ds''\1>1 
<ds\5 as\4 ds'\3 fs'\2 as'\1>1 
<e\5 b\4 e'\3 gs'\2 b'\1>1 
<fs\5 cs'\4 fs'\3 as'\2 cs''\1>1 
<gs\5 ds'\4 gs'\3 b'\2 ds''\1>1 
<ds\5 as\4 ds'\3 fs'\2 as'\1>1 
<e\5 b\4 e'\3 gs'\2 b'\1>1 
<fs\5 cs'\4 fs'\3 as'\2 cs''\1>1 
<b,\6 fs\5 b\4 ds'\3 fs'\2 b'\1>1 
<e\5 b\4 e'\3 gs'\2 b'\1>1 
<b,\6 fs\5 b\4 ds'\3 fs'\2 b'\1>1 
<e\5 b\4 e'\3 gs'\2 b'\1>1 
<b,\6 fs\5 b\4 ds'\3 fs'\2 b'\1>1 
<e\5 b\4 e'\3 gs'\2 b'\1>1 
<fs\5 cs'\4 fs'\3 as'\2 cs''\1>1 
<gs\5 ds'\4 gs'\3 b'\2 ds''\1>1 
<ds\5 as\4 ds'\3 fs'\2 as'\1>1 
<e\5 b\4 e'\3 gs'\2 b'\1>1 
<b,\6 fs\5 b\4 ds'\3 fs'\2 b'\1>1 
<fs\5 cs'\4 fs'\3 as'\2 cs''\1>1 
<e\5 b\4 e'\3 gs'\2 b'\1>1 
<fs\5 cs'\4 fs'\3 as'\2 cs''\1>1 
<gs\5 ds'\4 gs'\3 b'\2 ds''\1>1 
<ds\5 as\4 ds'\3 fs'\2 as'\1>1 
<e\5 b\4 e'\3 gs'\2 b'\1>1 
<b,\6 fs\5 b\4 ds'\3 fs'\2 b'\1>1 
<fs\5 cs'\4 fs'\3 as'\2 cs''\1>1 
<b,\6 fs\5 b\4 ds'\3 fs'\2 b'\1>1 
<e\5 b\4 e'\3 gs'\2 b'\1>1 
<fs\5 cs'\4 fs'\3 as'\2 cs''\1>1 
<gs\5 ds'\4 gs'\3 b'\2 ds''\1>1 
<ds\5 as\4 ds'\3 fs'\2 as'\1>1 
<e\5 b\4 e'\3 gs'\2 b'\1>1 
<b,\6 fs\5 b\4 ds'\3 fs'\2 b'\1>1 
<fs\5 cs'\4 fs'\3 as'\2 cs''\1>1 
<b,\6 fs\5 b\4 ds'\3 fs'\2 b'\1>1 
<e\5 b\4 e'\3 gs'\2 b'\1>1 
<fs\5 cs'\4 fs'\3 as'\2 cs''\1>1 
<gs\5 ds'\4 gs'\3 b'\2 ds''\1>1 
<ds\5 as\4 ds'\3 fs'\2 as'\1>1 
<e\5 b\4 e'\3 gs'\2 b'\1>1 
<b,\6 fs\5 b\4 ds'\3 fs'\2 b'\1>1 
<fs\5 cs'\4 fs'\3 as'\2 cs''\1>1 
<b,\6 fs\5 b\4 ds'\3 fs'\2 b'\1>1 
<e\5 b\4 e'\3 gs'\2 b'\1>1 
<fs\5 cs'\4 fs'\3 as'\2 cs''\1>1 
<gs\5 ds'\4 gs'\3 b'\2 ds''\1>1 
<ds\5 as\4 ds'\3 fs'\2 as'\1>1 
<e\5 b\4 e'\3 gs'\2 b'\1>1 
<b,\6 fs\5 b\4 ds'\3 fs'\2 b'\1>1 
<fs\5 cs'\4 fs'\3 as'\2 cs''\1>1 
<b,\6 fs\5 b\4 ds'\3 fs'\2 b'\1>1 
<e\5 b\4 e'\3 gs'\2 b'\1>1 
<fs\5 cs'\4 fs'\3 as'\2 cs''\1>1 
<gs\5 ds'\4 gs'\3 b'\2 ds''\1>1 
<ds\5 as\4 ds'\3 fs'\2 as'\1>1 
<e\5 b\4 e'\3 gs'\2 b'\1>1 
<fs\5 cs'\4 fs'\3 as'\2 cs''\1>1 
<gs\5 ds'\4 gs'\3 b'\2 ds''\1>1 
<ds\5 as\4 ds'\3 fs'\2 as'\1>1 
<e\5 b\4 e'\3 gs'\2 b'\1>1 
<fs\5 cs'\4 fs'\3 as'\2 cs''\1>1 
<gs\5 ds'\4 gs'\3 b'\2 ds''\1>1 
<ds\5 as\4 ds'\3 fs'\2 as'\1>1 
<e\5 b\4 e'\3 gs'\2 b'\1>1 
<fs\5 cs'\4 fs'\3 as'\2 cs''\1>1 
<b,\6 fs\5 b\4 ds'\3 fs'\2 b'\1>1 

}

%% 楽譜全体
\score {
  <<
    
    % %% ボーカル
    % \context Staff = "1" \with { instrumentName = "Vocal" } { % 男声の場合 \clef "G_8" を加える
    %   \scoredefault
    %   \vocal
    % }
    % %%歌詞
    % \addlyrics {
    %   \lyric
    % }

    \context ChordNames = "1" {
	\chord
    }

    % ギターダイアグラム表示
    \context FretBoards = "2" {
	% \chord
    }
    
    %%ギター
    \context StaffGroup <<
      \context Staff = "3" \with { instrumentName = "Guitar" \clef "G_8" } {
	\guitar
      }

      \context TabStaff = "4" {
	\guitar
      }
    >>

    \context Lyrics = "5" {
      \lyric
    }
    
  >>
  \layout {			% 弦番号指示を削除
    \context { \Voice
	       \remove New_fingering_engraver
	     }
  }  
}