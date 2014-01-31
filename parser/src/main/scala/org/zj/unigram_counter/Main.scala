package org.zj.unigram_counter

import java.io.{File, PrintWriter}
import java.io.StringReader

import scala.io.Source
import scala.collection.immutable.Map
import scala.collection.JavaConversions._

import edu.stanford.nlp.ling.Sentence
import edu.stanford.nlp.ling.TaggedWord
import edu.stanford.nlp.ling.HasWord
import edu.stanford.nlp.tagger.maxent.MaxentTagger

object Main {
  def main(args: Array[String]) = {
    val file = Source.fromFile("../data/corpus.txt")
    val lines = file.getLines
    val tagger = getTagger
    val tagMappings = getTagMappings

    println("Part-of-Speech tagging in progress...")
    val unigrams : Seq[(String, String)] = lines.map(tagging(tagger)).toSeq.flatten.map(normalizeTags(tagMappings))
    val noun = (unigrams filter { case (word, tag) => tag == "NOUN" })
    val adv  = (unigrams filter { case (word, tag) => tag == "ADV"  })
    val adj  = (unigrams filter { case (word, tag) => tag == "ADJ"  })

    println("Writing results...")
    sortAndWrite(noun)("../data/noun.txt")
    sortAndWrite(adv)("../data/adv.txt")
    sortAndWrite(adj)("../data/adj.txt")
  }

  private[this] def getTagger : MaxentTagger =
    new MaxentTagger("pos/english-bidirectional-distsim.tagger")

  private[this] def tagging(tagger: MaxentTagger)(s: String) : Seq[(String, String)] = {
    val sentences = MaxentTagger.tokenizeText(new StringReader(s))

    sentences.map(tagOneSentence(tagger)).flatten.map({ (tagWord: TaggedWord) =>
      (tagWord.word(), tagWord.tag())
    })
  }

  private[this] def tagOneSentence(tagger: MaxentTagger)(sentence: java.util.List[HasWord]) : Seq[TaggedWord] = tagger.tagSentence(sentence)

  private[this] def getTagMappings : Map[String, String] = {
    val mapFile = Source.fromFile("../data/en-ptb.map")
    val mapFileLines = mapFile.getLines
    val tagMappings = mapFileLines.map { s =>
      s.split('\t') match {
        case Array(k: String, v: String) => (k, v)
        case _ => ("", "")
      }
    }

    tagMappings.toMap
  }

  private[this] def normalizeTags(tagMap: Map[String, String])(s: (String, String)) : (String, String) = s match {
    case (word, tag) => (word, tagMap.get(tag).orElse(Option[String]("")).get)
  }

  private[this] def sortAndWrite = (sortByFrequency _) andThen writeToFile

  private[this] def sortByFrequency(s: Seq[(String, String)]) = {
    s.groupBy(_._1).mapValues(_.size).toList.sortBy(_._2).reverse
  }

  private[this] def writeToFile(s: Seq[(String, Int)])(fileName: String) = {
    val strToWrite = s.map({
      case (word, times) => s"$word\t$times"
    }).mkString("\n")


    val file = new File(fileName)
    val printer = new PrintWriter(file, "UTF-8")
    printer.print(strToWrite)
    printer.close
  }
}
