%%% 弾き語り用TAB譜のテンプレート2

\language "english"		% 言語設定(英語)
\include "predefined-guitar-fretboards.ly"
\version "2.18.2"

%%ヘッダー
\header {                       
title = "ハッピーバースデートゥーユー"
subtitle = "童謡・唱歌・合唱"
composer = "Mildred J.Hill & Patty S.Hill"
arranger = "Mildred J.Hill & Patty S.Hill"
}

%% ボーカル
vocal =  \relative c' {

}

%% 歌詞
lyric = \lyricmode {
ハッピーバースデートゥー4 ユー2 ハッピーバースデイトゥ1 ユー2 ハッピーバースデイディア1 〇〇4 ・・・2. ハッピー1 バースデイ1 トゥ1 ユー1 
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
c4 g2 g1 c2 c1 g4:7 f2. f1 c1 g1:7 c1 
}

%% ギター(コードを表示したい音符に^""でできる)
guitar = {
\key c \major
  \time 4/4
<c\5 e\4 g\3 c'\2 e'\1>4 
<g,\6 b,\5 d\4 g\3 b\2 g'\1>2 
<g,\6 b,\5 d\4 g\3 b\2 g'\1>4 <g,\6 b,\5 d\4 g\3 b\2 g'\1>4 <g,\6 b,\5 d\4 g\3 b\2 g'\1>4 <g,\6 b,\5 d\4 g\3 b\2 g'\1>4 
<c\5 e\4 g\3 c'\2 e'\1>2 
<c\5 e\4 g\3 c'\2 e'\1>4 <c\5 e\4 g\3 c'\2 e'\1>4 <c\5 e\4 g\3 c'\2 e'\1>4 <c\5 e\4 g\3 c'\2 e'\1>4 
<g,\6 b,\5 d\4 g\3 b\2 f'\1>4 
<f,\6 c\5 f\4 a\3 c'\2 f'\1>4 c8 e8 g8 c'8 
<f,\6 c\5 f\4 a\3 c'\2 f'\1>1 
<c\5 e\4 g\3 c'\2 e'\1>1 
<g,\6 b,\5 d\4 g\3 b\2 f'\1>1 
<c\5 e\4 g\3 c'\2 e'\1>1 

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
	\chord
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