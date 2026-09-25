#!/usr/bin/env bash
# Helper script to retrieve syllabus info and textbook snippets for a specific week
# Usage: ./get_week_info.sh <IS501|IS507> <week_number>

COURSE="$(echo "${1:-IS507}" | tr '[:lower:]' '[:upper:]')"
WEEK="${2:-1}"

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../../.." && pwd)"

echo "=== Course: $COURSE | Week: $WEEK ==="

if [ "$COURSE" = "IS501" ]; then
  case "$WEEK" in
    1)  CHAPTER="Chapter 1"; QUERY="Information Systems in Global Business Today";;
    2)  CHAPTER="Chapter 2"; QUERY="Global E-Business How Businesses Use";;
    3)  CHAPTER="Chapter 3"; QUERY="Information Systems Organizations and Strategy";;
    4)  CHAPTER="Chapter 4"; QUERY="Ethical and Social Issues in Information Systems";;
    5)  CHAPTER="Chapter 9"; QUERY="Enterprise Applications";;
    6)  CHAPTER="Chapter 10"; QUERY="Digital Markets Digital Goods";;
    7)  CHAPTER="Chapter 11"; QUERY="Managing Knowledge";;
    8)  CHAPTER="Chapter 12"; QUERY="Enhancing Decision Making";;
    9)  CHAPTER="Chapter 13"; QUERY="Building Systems";;
    10) CHAPTER="Chapter 14"; QUERY="Project Management Establishing the Business Value";;
    11) CHAPTER="Chapter 15"; QUERY="Managing Global Systems";;
    12) CHAPTER="Chapter 8"; QUERY="Securing Information Systems";;
    *)  CHAPTER="All"; QUERY="Information Systems";;
  esac
  echo "Assigned Reading: Laudon & Laudon $CHAPTER"
  "$REPO_DIR/scripts/search_textbook.sh" IS501 "$QUERY" 2
elif [ "$COURSE" = "IS507" ]; then
  case "$WEEK" in
    1)  CHAPTER="Chapter 1"; QUERY="Software and Software Engineering";;
    2)  CHAPTER="Chapter 2"; QUERY="Process Models";;
    3)  CHAPTER="Chapter 3"; QUERY="Agile Development";;
    4)  CHAPTER="Chapter 3"; QUERY="Extreme Programming";;
    5)  CHAPTER="Chapter 5"; QUERY="Understanding Requirements";;
    6)  CHAPTER="Chapters 5 & 6"; QUERY="Requirements Analysis";;
    7)  CHAPTER="Chapters 6 & 7"; QUERY="Data Flow Diagrams";;
    8)  CHAPTER="Chapters 6 & 7"; QUERY="UML diagrams";;
    9)  CHAPTER="Chapter 7"; QUERY="State diagrams";;
    10) CHAPTER="Chapters 26 & 27"; QUERY="COCOMO";;
    11) CHAPTER="Chapter 28"; QUERY="Risk Management";;
    12) CHAPTER="Chapters 8 & 9"; QUERY="Design Principles";;
    13) CHAPTER="Research"; QUERY="AI in Software Engineering";;
    *)  CHAPTER="Review"; QUERY="Software Engineering";;
  esac
  echo "Assigned Reading: Pressman $CHAPTER"
  "$REPO_DIR/scripts/search_textbook.sh" IS507 "$QUERY" 2
fi
