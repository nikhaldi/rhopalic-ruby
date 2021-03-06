rhopalic
========

A Ruby library to detect rhopalic phrases in English, i.e., a phrase in which each
word contains one letter or one syllable more than the previous word.

Available as [a gem](https://rubygems.org/gems/rhopalic).

## Usage

For simple yes or no answers about whether a phrase is rhopalic:

	> require 'rhopalic'
	=> true
	> Rhopalic.letter_rhopalic?("I do not know where family doctors acquired illegibly perplexing handwriting.")
	=> true
	> Rhopalic.syllable_rhopalic?("Lines thicken approaching termination.")
	=> true

There is no exact algorithm for counting syllables in English. For more accurate syllable
counting use the [CMU pronunciation dictionary](http://www.speech.cs.cmu.edu/cgi-bin/cmudict):

    > require 'rhopalic'
    > require 'rhopalic/dictionary'
	> dict = Rhopalic::Dictionary.from_file('cmudict.0.7a')
	=> ...
	> analysis = Rhopalic::Analysis.new(dict)
	=> ...
	> analysis.analyze_phrase("Add extra syllables gradually").syllable_rhopalic?
	=> true

(This is assuming that you have the dictionary file cmudict.0.7a in your working directory.)

## License

Distributed under an [MIT license](https://github.com/nikhaldi/rhopalic-ruby/blob/master/LICENSE.md).
