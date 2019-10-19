module Corenlp
  module Annotator
    TokenizerAnnotator = 'tokenize'
    CleanXmlAnnotator = 'cleanxml'
    WordsToSentenceAnnotator = 'ssplit'
    POSTaggerAnnotator = 'pos'
    MorphaAnnotator = 'lemma'
    NERClassifierCombiner = 'ner'
    RegexNERAnnotator = 'regexner'
    SentimentAnnotator = 'sentiment'
    ParserAnnotator = 'parse'
    DependencyParseAnnotator = 'depparse'
    DeterministicCorefAnnotator = 'dcoref'
    CorefAnnotator = 'coref'
    RelationExtractorAnnotator = 'relation'
    NaturalLogicAnnotator = 'natlog'
    WikiDictAnnotator = 'entitylink'
    KBPAnnotator = 'kbp'
    QuoteAnnotator = 'quote'

    ALL_ANNOTATORS = [
      TokenizerAnnotator,
      CleanXmlAnnotator,
      WordsToSentenceAnnotator,
      POSTaggerAnnotator,
      MorphaAnnotator,
      NERClassifierCombiner,
      RegexNERAnnotator,
      SentimentAnnotator,
      ParserAnnotator,
      DependencyParseAnnotator,
      DeterministicCorefAnnotator,
      CorefAnnotator,
      RelationExtractorAnnotator,
      NaturalLogicAnnotator,
      WikiDictAnnotator,
      KBPAnnotator,
      QuoteAnnotator
    ]

    DEFAULT_ANNOTATORS = [

    ]
  end
end
