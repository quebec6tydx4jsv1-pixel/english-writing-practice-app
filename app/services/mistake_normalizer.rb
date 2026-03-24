class MistakeNormalizer
  CATEGORY_MAP = {
    'tense' => '時制',
    'capitalization' => '大文字',
    'collocation' => '語法'
  }.freeze

  ALLOWED_CATEGORIES = %w[時制 大文字 語法 語彙 前置詞].freeze
  MAX_CHARS = 40
  MAX_WORDS = 4

  def initialize(raw_hash, ai_correction = nil)
    @m = raw_hash || {}
    @ai_correction = ai_correction
  end

  # 戻り値は保存用 attrs ハッシュ
  def call
    token = short_token_from(@m)
    category = normalize_category(@m['category'])
    reason = build_reason(@m)

    category = 'その他' unless ALLOWED_CATEGORIES.include?(category)

    {
      expression_text: token,
      category: category,
      reason: reason
    }
  end

  private

  def normalize_category(raw)
    return nil if raw.nil?
    CATEGORY_MAP.fetch(raw.to_s.downcase.strip, raw.to_s)
  end

  def short_token_from(m)
    # 1) pattern 優先（空白正規化して短ければそのまま）
    if present?(m['pattern'])
      token = m['pattern'].to_s.gsub(/\s+/, ' ').strip
      return token.length <= MAX_CHARS ? token : token[0, MAX_CHARS]
    end

    # 2) correct_expression の先頭句から主要語句を抽出（最大 MAX_WORDS）
    text = m['correct_expression'].to_s.split(/[.?!]/).first.to_s.strip
    return fallback_token(text) if text.empty?

    words = text.split
    token = if words.size <= MAX_WORDS
              words.join(' ')
            else
              # 意味を保つため最初の MAX_WORDS を採る（簡易実装）
              words.take(MAX_WORDS).join(' ')
            end

    token = token.strip
    token.empty? ? fallback_token(text) : (token.length <= MAX_CHARS ? token : token[0, MAX_CHARS])
  end

  def fallback_token(text)
    t = text.to_s.strip
    return '（無題）' if t.empty?
    t.length <= MAX_CHARS ? t : t[0, MAX_CHARS]
  end

  def build_reason(m)
    parts = []
    parts << m['reason'].to_s.strip if present?(m['reason'])
    parts << "例: #{m['correct_expression']}" if present?(m['correct_expression'])
    # pattern は必ず reason に付記（存在しない場合は付記しない）
    parts << "pattern: #{m['pattern']}" if present?(m['pattern'])
    parts.join(' ; ')
  end

  def present?(v)
    v.respond_to?(:present?) ? v.present? : !v.nil? && v.to_s.strip != ''
  end
end