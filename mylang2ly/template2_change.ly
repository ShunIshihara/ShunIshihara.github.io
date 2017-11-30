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
piece = "Capo:0"
}

%% 楽譜設定
scoredefault = {
  \key c \major
  % \tempo 4 = 120
}


%% ボーカル
vocal =  \relative c' {

}

%% 歌詞
lyric = \lyricmode {

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

}

%% ギター(コードを表示したい音符に^""でできる)
guitar = {
  \key c \major
  \time 4/4
  \tempo 4 = 120
<c\5 e\4 g\3 c'\2 e'\1>8 <c\5 e\4 g\3 c'\2 e'\1>8 <c\5 e\4 g\3 c'\2 e'\1>8 <c\5 e\4 g\3 c'\2 e'\1>8 <g,\6 b,\5 d\4 g\3 b\2 g'\1>8 r8 <g,\6 b,\5 d\4 g\3 b\2>8 <g,\6 b,\5 d\4 g\3 b\2>8 <g,\6 b,\5 d\4 g\3 b\2 g'\1>8 <g,\6 b,\5 d\4 g\3 b\2>8 <g,\6 b,\5 d\4 g\3 b\2>8 r8 <c\5 e\4 g\3 c'\2 e'\1>4 <c\5 e\4 g\3 c'\2 e'\1>8 <c\5 e\4 g\3 c'\2 e'\1>8 <c\5 e\4 g\3 c'\2 e'\1>8 <c\5 e\4 g\3 c'\2 e'\1>8 <c\5 e\4 g\3 c'\2 e'\1>4 <c\5 g\4 c'\3 e'\2 g'\1>8 <c\5 g\4 c'\3 e'\2 g'\1>8 <c\5 g\4 c'\3 e'\2 g'\1>8 <c\5 g\4 c'\3 e'\2 g'\1>8 <g,\6 b,\5 d\4 g\3 b\2 f'\1>8 <g,\6 b,\5 d\4 g\3 b\2 f'\1>8 <g,\6 b,\5 d\4 g\3 b\2 f'\1>8 <g,\6 b,\5 d\4 g\3 b\2 f'\1>8 <f,\6 f\4>8 <c\5>8 <f\4>8 <a\3>8 <f,\6 f\4>8 <c\5>8 <f\4>8 <a\3>8 <c\5 g\3>8 <e\4>8 <g\3>8 <c'\2>8 <g,\6 d\4>8 <b,\5>8 <d\4>8 <g\3>8 <c\5 g\3>8 <e\4>8 <g\3>8 <c'\2>8 <c\5 g\3>8 <e\4>8 <g\3>8 <c'\2>8 
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
      \lyricmode{

      }
    }
    
  >>
  \layout {			% 弦番号指示を削除
    \context { \Voice
	       \remove New_fingering_engraver
	     }
  }  
}