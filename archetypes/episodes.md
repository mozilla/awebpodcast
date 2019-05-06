---
date: {{ substr .Name 0 10 }}T00:00:00-00:00
title: "{{ replace (substr .Name 18) "-" " " | title }}"
ogtitle: "{{ replace (substr .Name 18) "-" " " | title }}"
description: ""
ogdescription: ""
season: {{ strings.TrimPrefix "0" (substr .Name 12 2) }}
seasonepisode: {{ strings.TrimPrefix "0" (substr .Name 15 2) }}
url: /staffel{{ strings.TrimPrefix "0" (substr .Name 12 2) }}/folge{{ strings.TrimPrefix "0" (substr .Name 15 2) }}/
embed: ""
categories: "episodes"
shownotes: |
transcript: |

---
