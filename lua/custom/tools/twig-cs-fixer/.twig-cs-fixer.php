<?php

$ruleset = new TwigCsFixer\Ruleset\Ruleset();
$ruleset->addStandard(new TwigCsFixer\Standard\Twig());
$ruleset->addStandard(new TwigCsFixer\Standard\TwigCsFixer());

// $ruleset->addRule(new TwigCsFixer\Rules\Whitespace\BlankEOFRule());
// $ruleset->addRule(new TwigCsFixer\Rules\Whitespace\EmptyLinesRule());
// $ruleset->addRule(new TwigCsFixer\Rules\Whitespace\IndentRule());
// $ruleset->addRule(new TwigCsFixer\Rules\Whitespace\TrailingSpaceRule());

// $ruleset->addRule(new TwigCsFixer\Rules\Delimiter\BlockNameSpacingRule());
// $ruleset->addRule(new TwigCsFixer\Rules\Delimiter\DelimiterSpacingRule());

// $ruleset->addRule(new TwigCsFixer\Rules\Function\IncludeFunctionRule());

// $ruleset->addRule(new TwigCsFixer\Rules\Operator\OperatorNameSpacingRule());
// $ruleset->addRule(new TwigCsFixer\Rules\Operator\OperatorSpacingRule());

// $ruleset->addRule(new TwigCsFixer\Rules\Punctuation\PunctuationSpacingRule());
// $ruleset->addRule(new TwigCsFixer\Rules\Punctuation\TrailingCommaSingleLineRule());

$ruleset->removeRule(TwigCsFixer\Rules\Whitespace\IndentRule::class);

$config = new TwigCsFixer\Config\Config();
$config->setCacheFile('/tmp/.twig-cs-fixer.cache');
$config->setRuleset($ruleset);

return $config;
