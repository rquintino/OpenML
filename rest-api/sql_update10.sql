ALTER TABLE implementation
  DROP `format`,
  DROP `type`,
  DROP `readme`,
  DROP `summary`,
  CHANGE column `technicalManual` `installationNotes` TEXT NULL DEFAULT NULL,
  CHANGE column `dependency` `dependencies` TEXT NULL DEFAULT NULL,
  CHANGE column `language` `language` varchar(128) NULL DEFAULT NULL AFTER `licence`,
  CHANGE column `date` `date` DATETIME NULL DEFAULT NULL,
  CHANGE column `sourceCodeUrl` `sourceUrl` VARCHAR(256) NULL DEFAULT NULL,
  CHANGE column `sourceCodeMd5` `sourceCodeMd5` VARCHAR(64) NULL DEFAULT NULL,
  ADD `binaryFormat` VARCHAR(64) NULL DEFAULT NULL AFTER `binaryUrl`,
  ADD `sourceFormat` VARCHAR(64) NULL DEFAULT NULL AFTER `sourceCodeUrl`;

ALTER TABLE `bibliographical_reference`
	CHANGE `implementation_id` `implementation` VARCHAR(128) NOT NULL;
  
DROP TABLE `estimation_procedure`;
DROP TABLE `estimation_procedure_parameter`;
DROP TABLE `prediction`;
DROP TABLE `prediction_feature`;
DROP TABLE `task`;
DROP TABLE `task_dataset`;
DROP TABLE `task_estimation_procedure`;
DROP TABLE `task_function`;
DROP TABLE `task_prediction`;
DROP TABLE `task_type`;
DROP TABLE `task_type_input`;
DROP TABLE `task_type_output`;
DROP TABLE `task_type_parameter`;

--
-- Tabelstructuur voor tabel `task`
--

CREATE TABLE IF NOT EXISTS `task` (
  `task_id` int(10) NOT NULL AUTO_INCREMENT,
  `ttid` int(10) NOT NULL,
  PRIMARY KEY (`task_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Gegevens worden uitgevoerd voor tabel `task`
--

INSERT INTO `task` (`task_id`, `ttid`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `task_type`
--

CREATE TABLE IF NOT EXISTS `task_type` (
  `ttid` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `description` text NOT NULL,
  `creator` varchar(128) NOT NULL,
  `contributors` text,
  `date` date NOT NULL,
  PRIMARY KEY (`ttid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Gegevens worden uitgevoerd voor tabel `task_type`
--

INSERT INTO `task_type` (`ttid`, `name`, `description`, `creator`, `contributors`, `date`) VALUES
(1, 'Supervised Classification', 'Given a dataset with a classification target and a set of train/test splits, e.g. generated by a cross-validation procedure, train a model and return the predictions of that model.', 'Joaquin Vanschoren', '"Jan van Rijn","Bo Gao","Simon Fisher","Venkatesh Umaashankar","Luis Torgo","Bernd Bischl","Michael Berthold","Bernd Wiswedel","Patrick Winter"', '2013-01-24');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `task_type_data_set`
--

CREATE TABLE IF NOT EXISTS `task_type_data_set` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `ttid` int(10) NOT NULL,
  `name` varchar(128) NOT NULL,
  `description` text NOT NULL,
  `data_set_id` varchar(64) NOT NULL,
  `target_feature` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Gegevens worden uitgevoerd voor tabel `task_type_data_set`
--

INSERT INTO `task_type_data_set` (`id`, `ttid`, `name`, `description`, `data_set_id`, `target_feature`) VALUES
(1, 1, 'source_data', 'The source data used to evaluate the model', 'input:1', 'input:2');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `task_type_estimation_procedure`
--

CREATE TABLE IF NOT EXISTS `task_type_estimation_procedure` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `ttid` int(10) NOT NULL,
  `name` varchar(128) NOT NULL,
  `description` text NOT NULL,
  `type` varchar(64) NOT NULL,
  `data_splits_url` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Gegevens worden uitgevoerd voor tabel `task_type_estimation_procedure`
--

INSERT INTO `task_type_estimation_procedure` (`id`, `ttid`, `name`, `description`, `type`, `data_splits_url`) VALUES
(1, 1, 'estimation_procedure', 'The evaluation procedure used to evaluate the model', 'input:3', 'input:4');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `task_type_estimation_procedure_parameter`
--

CREATE TABLE IF NOT EXISTS `task_type_estimation_procedure_parameter` (
  `id` int(10) NOT NULL,
  `name` varchar(64) NOT NULL,
  `value` varchar(64) NOT NULL,
  PRIMARY KEY (`id`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Gegevens worden uitgevoerd voor tabel `task_type_estimation_procedure_parameter`
--

INSERT INTO `task_type_estimation_procedure_parameter` (`id`, `name`, `value`) VALUES
(1, 'number_folds', 'input:6'),
(1, 'number_repeats', 'input:5'),
(1, 'stratified_sampling', 'true');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `task_type_evaluation_measures`
--

CREATE TABLE IF NOT EXISTS `task_type_evaluation_measures` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `ttid` int(10) NOT NULL,
  `name` varchar(64) NOT NULL,
  `description` text NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Gegevens worden uitgevoerd voor tabel `task_type_evaluation_measures`
--

INSERT INTO `task_type_evaluation_measures` (`id`, `ttid`, `name`, `description`, `value`) VALUES
(1, 1, 'evaluation_measures', 'Optional. A list of evaluation measures to optimize for', 'input:8');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `task_type_parameter`
--

CREATE TABLE IF NOT EXISTS `task_type_parameter` (
  `ttid` int(10) NOT NULL,
  `name` varchar(64) NOT NULL,
  `value` varchar(64) NOT NULL,
  PRIMARY KEY (`ttid`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `task_type_prediction`
--

CREATE TABLE IF NOT EXISTS `task_type_prediction` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `ttid` int(10) NOT NULL,
  `name` varchar(128) NOT NULL,
  `description` text NOT NULL,
  `format` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Gegevens worden uitgevoerd voor tabel `task_type_prediction`
--

INSERT INTO `task_type_prediction` (`id`, `ttid`, `name`, `description`, `format`) VALUES
(1, 1, 'predictions', 'The predictions returned by your implementation.', 'ARFF');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `task_type_prediction_feature`
--

CREATE TABLE IF NOT EXISTS `task_type_prediction_feature` (
  `id` int(10) NOT NULL,
  `name` varchar(64) NOT NULL,
  `type` varchar(64) NOT NULL,
  PRIMARY KEY (`id`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Gegevens worden uitgevoerd voor tabel `task_type_prediction_feature`
--

INSERT INTO `task_type_prediction_feature` (`id`, `name`, `type`) VALUES
(1, 'confidence.classname', 'numeric'),
(1, 'fold', 'integer'),
(1, 'prediction', 'string'),
(1, 'repeat', 'integer'),
(1, 'row_id', 'integer');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `task_values`
--

CREATE TABLE IF NOT EXISTS `task_values` (
  `task_id` int(10) NOT NULL,
  `input` int(10) NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`task_id`,`input`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;