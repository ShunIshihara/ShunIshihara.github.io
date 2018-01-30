%%% 弾き語り用TAB譜のテンプレート2

\language "english"		% 言語設定(英語)
\include "predefined-guitar-fretboards.ly"
\version "2.18.2"

%%ヘッダー
\header {                       
}

%% ボーカル
vocal =  \relative c' {

}

%% 歌詞
lyric = \lyricmode {
　1 　1 　1 　1 
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
c1 f1 g1 c1 
}

%% ギター(コードを表示したい音符に^""でできる)
guitar = {
\key c \major
  \time 4/4
<c\5 g\4>8 <c\5 g\4>8 <c\5 g\4>4 <c\5 g\4>8 <c\5 g\4>8 <c\5 g\4>4 
<f,\6 c\5 f\4 a\3 c'\2 f'\1>4 <f,\6 c\5 f\4 a\3 c'\2 f'\1>8 <f,\6 c\5 f\4 a\3 c'\2 f'\1>8 <f,\6 c\5 f\4 a\3 c'\2 f'\1>8 <f,\6 c\5 f\4 a\3 c'\2 f'\1>8 <f,\6 c\5 f\4 a\3 c'\2 f'\1>8 <f,\6 c\5 f\4 a\3 c'\2 f'\1>8 
<d\5>8 <g\4>8 <b\3>8 <d\5>8 <g\4>8 <b\3>8 <g,\6 d\5 g\4 b\3 d'\2>4 
<c\5 g\4 c'\3 e'\2 g'\1>1 

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