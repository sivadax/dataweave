/*
[
  {
    "self": "https://api.tempo.io/core/3/worklogs/5408",
    "tempoWorklogId": 5408,
    "jiraWorklogId": 15408,
    "issue": {
      "self": "https://xpto.atlassian.net/rest/api/2/issue/ABC-123",
      "key": "ABC-123",
      "id": 11005
    },
    "timeSpentSeconds": 28800,
    "billableSeconds": 28800,
    "startDate": "2020-01-31",
    "startTime": "00:00:00",
    "description": "creating new song",
    "createdAt": "2020-02-28T13:30:58Z",
    "updatedAt": "2020-02-28T13:30:58Z",
    "author": {
      "self": "https://xpto.atlassian.net/rest/api/2/user?accountId=5d8b681427fe990dc2d3404a",
      "accountId": "5d8b681427fe990dc2d3404a",
      "displayName": "john lennon"
    },
    "attributes": {
      "self": "https://api.tempo.io/core/3/worklogs/5408/work-attribute-values",
      "values": [
        
      ]
    }
  },
  {
    "self": "https://api.tempo.io/core/3/worklogs/5166",
    "tempoWorklogId": 5166,
    "jiraWorklogId": 15166,
    "issue": {
      "self": "https://xpto.atlassian.net/rest/api/2/issue/CDE-99",
      "key": "CDE-99",
      "id": 10106
    },
    "timeSpentSeconds": 3600,
    "billableSeconds": 3600,
    "startDate": "2020-01-31",
    "startTime": "00:00:00",
    "description": "call with stakeholders",
    "createdAt": "2020-02-10T18:30:03Z",
    "updatedAt": "2020-02-10T18:30:03Z",
    "author": {
      "self": "https://xpto.atlassian.net/rest/api/2/user?accountId=5b27ad3902cfea1ba6411c3f",
      "accountId": "5b27ad3902cfea1ba6411c3f",
      "displayName": "chandler bing"
    },
    "attributes": {
      "self": "https://api.tempo.io/core/3/worklogs/5166/work-attribute-values",
      "values": [
        
      ]
    }
  },
  {
    "self": "https://api.tempo.io/core/3/worklogs/5165",
    "tempoWorklogId": 5165,
    "jiraWorklogId": 15165,
    "issue": {
      "self": "https://xpto.atlassian.net/rest/api/2/issue/CDE-99",
      "key": "CDE-99",
      "id": 10081
    },
    "timeSpentSeconds": 3600,
    "billableSeconds": 3600,
    "startDate": "2020-01-31",
    "startTime": "00:00:00",
    "description": "planning tulsa work trip",
    "createdAt": "2020-02-10T18:29:30Z",
    "updatedAt": "2020-02-10T18:29:30Z",
    "author": {
      "self": "https://xpto.atlassian.net/rest/api/2/user?accountId=5b27ad3902cfea1ba6411c3f",
      "accountId": "5b27ad3902cfea1ba6411c3f",
      "displayName": "chandler bing"
    },
    "attributes": {
      "self": "https://api.tempo.io/core/3/worklogs/5165/work-attribute-values",
      "values": [
        
      ]
    }
  },
  {
    "self": "https://api.tempo.io/core/3/worklogs/5164",
    "tempoWorklogId": 5164,
    "jiraWorklogId": 15164,
    "issue": {
      "self": "https://xpto.atlassian.net/rest/api/2/issue/CDE-99",
      "key": "CDE-99",
      "id": 10108
    },
    "timeSpentSeconds": 7200,
    "billableSeconds": 7200,
    "startDate": "2020-01-31",
    "startTime": "00:00:00",
    "description": "exporting data to cd-rom",
    "createdAt": "2020-02-10T18:29:08Z",
    "updatedAt": "2020-02-10T18:29:47Z",
    "author": {
      "self": "https://xpto.atlassian.net/rest/api/2/user?accountId=5b27ad3902cfea1ba6411c3f",
      "accountId": "5b27ad3902cfea1ba6411c3f",
      "displayName": "chandler-bing"
    },
    "attributes": {
      "self": "https://api.tempo.io/core/3/worklogs/5164/work-attribute-values",
      "values": [
        
      ]
    }
  }
]

*/

%dw 2.0
output application/json
---
vars.worklogs groupBy $.author.accountId pluck {
    accountId: $.author.accountId[0],
    displayName: $.author.displayName[0],
    timeSpentMinutesMonth: (sum($.timeSpentSeconds)) / 3600,
    billableMinutesMonth: (sum($.billableSeconds)) / 3600,
    emailAddress: ''
}
