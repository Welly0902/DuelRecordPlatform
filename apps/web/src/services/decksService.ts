import api from './api'

export interface DeckTemplate {
  id: string
  name: string
  theme: string
  deckType: 'main' | 'sub'
  createdAt: string
}

interface GetDeckTemplatesResponse {
  templates: DeckTemplate[]
  total: number
}

interface CreateDeckTemplateRequest {
  name: string
  theme: string
  deckType: 'main' | 'sub'
}

interface UpdateDeckTemplateRequest {
  name?: string
  theme?: string
}

export const decksService = {
  async getTemplates(type?: 'main' | 'sub'): Promise<GetDeckTemplatesResponse> {
    const params = type ? { type } : {}
    const response = await api.get<GetDeckTemplatesResponse>('/deck-templates', { params })
    return response.data
  },

  async createTemplate(data: CreateDeckTemplateRequest): Promise<{ id: string; message: string }> {
    const response = await api.post('/deck-templates', data)
    return response.data
  },

  async updateTemplate(id: string, data: UpdateDeckTemplateRequest): Promise<{ message: string }> {
    const response = await api.patch(`/deck-templates/${id}`, data)
    return response.data
  },

  async deleteTemplate(id: string): Promise<{ message: string }> {
    const response = await api.delete(`/deck-templates/${id}`)
    return response.data
  },
}

// 主題顏色配置
export type DeckTheme = 
  | '融合' | '超量' | '連結' | '同步' 
  | '陷阱' | '魔法' | '輔助' | '儀式' 
  | '鐘擺' | '無'

export const THEME_COLORS: Record<DeckTheme, { bg: string; text: string }> = {
  '融合': { bg: 'bg-purple-500', text: 'text-white' },       // 葡萄紫（融合卡邊框）
  '超量': { bg: 'bg-gray-900', text: 'text-white' },
  '連結': { bg: 'bg-blue-700', text: 'text-white' },
  '同步': { bg: 'bg-gray-200', text: 'text-gray-800' },
  '陷阱': { bg: 'bg-red-600', text: 'text-white' },
  '魔法': { bg: 'bg-emerald-600', text: 'text-white' },
  '輔助': { bg: 'bg-amber-700', text: 'text-white' },
  '儀式': { bg: 'bg-blue-500', text: 'text-white' },        // 深藍色（儀式卡邊框）
  '鐘擺': { bg: 'bg-teal-500', text: 'text-white' },
  '無': { bg: 'bg-gray-500', text: 'text-white' },
}

export const THEME_OPTIONS: DeckTheme[] = [
  '融合', '超量', '連結', '同步', '陷阱', '魔法', '輔助', '儀式', '鐘擺', '無'
]

// 根據牌組名稱取得顏色
export function getDeckColor(theme: string): { bg: string; text: string } {
  return THEME_COLORS[theme as DeckTheme] || THEME_COLORS['無']
}
