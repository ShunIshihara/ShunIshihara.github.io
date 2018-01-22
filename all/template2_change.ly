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
広い宇宙1 　2 　2 　2 　2 
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
b1 c2 c2 c2 c2 
}

%% ギター(コードを表示したい音符に^""でできる)
guitar = {
\key b \major
  \time 4/4
<b,\6 fs\5>4 <b,\6 fs\5>4 <b,\6 fs\5>4 <b,\6 fs\5>4 
<c\5 e\4>8 <c\5 e\4>8 <c\5 e\4>8 <c\5 e\4>8 
<c\5 e\4 g\3>8 <c\5 e\4 g\3>8 <c\5 e\4 g\3>8 <c\5 e\4 g\3>8 
<c\5 e\4 g\3>8 <c\5 e\4 g\3>8 <c\5 e\4 g\3>8 <c\5 e\4 g\3>8 
<c\5 e\4 g\3>8 <c\5 e\4 g\3>8 <c\5 e\4 g\3>8 <c\5 e\4 g\3>8 

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