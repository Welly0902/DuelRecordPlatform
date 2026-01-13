// 對局記錄資料型別定義

export interface DeckInfo {
  id: string
  main: string
  sub: string | null
}

export interface Match {
  id: string
  date: string
  rank: string
  myDeck: DeckInfo
  oppDeck: DeckInfo
  playOrder: '先攻' | '後攻'
  result: 'W' | 'L'
  note: string | null
  seasonCode: string
  createdAt: string
  updatedAt: string
}

export interface MatchesResponse {
  matches: Match[]
  total: number
}

export interface CreateMatchRequest {
  gameKey: string
  seasonCode: string
  date: string
  rank: string
  myDeck: {
    main: string
    sub: string | null
  }
  oppDeck: {
    main: string
    sub: string | null
  }
  playOrder: '先攻' | '後攻'
  result: 'W' | 'L'
  note?: string
}

export interface UpdateMatchRequest {
  date?: string
  rank?: string
  myDeck?: {
    main: string
    sub: string | null
  }
  oppDeck?: {
    main: string
    sub: string | null
  }
  playOrder?: '先攻' | '後攻'
  result?: 'W' | 'L'
  note?: string
}
