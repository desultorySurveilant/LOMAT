/*
 fenrir needs to be able to write words to the screen. roughly at head height. similar to magical girl sim
 needs to be timed, for him to just say BORK at you. and then say more things
 maybe sounds that are audio libed?
 */
import 'dart:async';
import 'dart:html';

import 'package:CommonLib/Compression.dart';
import 'package:CommonLib/Random.dart';

import '../Game.dart';
import '../GameStats.dart';
import '../NPCs/Tombstone.dart';

class Fenrir {

    static String HAPPY="HAPPY";
    static String NEUTRAL="NEUTRAL";
    static String ANGRY ="ANGRY";

    static String get opinion {
        GameStats gs = Game.instance.gameStats;
        if(gs.theDead.isEmpty && gs.voidVisits < 2) {
            return NEUTRAL;
        }else if(gs.theDead.isEmpty) {
            return HAPPY;
        }else if(gs.theDead.length < 2) {
            return NEUTRAL;
        }else {
            return ANGRY;
        }
    }

    static String friendText = "jgEHUBYIYC4AQMYQHYwJ4HsCuMoFMA2eMAtjjBAEaaxRgCWAzjAOYQkD8guAQA0qmZ9Aax4AHNHlq48KAHQwYAeQBm8TACd6OHuiwDEaAO4wcANxyqUNWoibYwZ0g2xoYug2UoZqdRixKyAogCOGBAEKFp8GIgAJmb0UEjRttC2pPTBEPoCVjZMGAQw5DiKaKqk2jwQxBAI5GXEtAAeMGjKoYTaqi14SYqqtDgx9DwIyHqwNVAhYTD0EChkiBZ01jAYGor5hTUCsgBCnqn1EPX0aCS2OYxoiGm0RMJSMAAi8v4AypUxs8I4ENmrKDOTrwSCqJg4RhFEr1RRmcw5VJEGCOG6kVpI6QAHjqAD4capccB3gBFEAAQRAAGkAIR0ukwACqADUYCB3gAZAASAC0OTAAHJcgAq-J55OZIBgPK5AGF+XseTAAEoABXe7xgiulEql5PkqqVAEk9gBNABiWp59Lp3FSTlUJEQuCSeQK9DA-RwAnoshgpr4emiPBomCYYCgmzC2LxBNxyr+4igC0U4mEvrjcYDGC6cFoqjgGAkjA0OGRQNmcFUrHIeBwskzeOzZH0J0GkKheDQ9DOREYwgg8UYNFI4iIEjixD+zqcLhwOGEvCwmTbLWUNyeaOw93wVk0iySG4WoY0LWQI5g-XDsHotFia-tIHafubZVCtAAXqQL-JyBpVKY6gwJApgqM6qhiHWSQgiYZgLJMtA3DwGCLlEUC0IQej6LIApuNoZCwmU9YwMKdgwMAexoFAHCFJ4QLII4egwF21hmE4TBMFBMaEnGpGkL+-6AYwIGkJMODRLIfEwOSBTmtAdhdI4cCQKxEkkQpDiMExrYLP4+a0AIXTRGgkIwOMLhYZcvpyI2hLNnUAypgsrbxN+O4wPoDArDYILCBBTDVkQ46rO0BjiUus6Fuo+7kIcIKym+QKqDwzyQgOi6yhI0BoDwLkwMEE7wHWJxnvaZyqFA1zKEUIGIV0EDCH5aB+bQ0CkDCZDMWFuZ4IOjB5uhX6INx+J4kaiCuRAwYRbesDGfoyA3PaVZRMpCzjs0GL0JZiQonAxF8fUjHOOhJDiLcHkaZc1g+M40S0IocJlM6Ughldx1kHA6FLfhozYP837OMpSAQosyw5LI7zAnwJBlE8rYSA2sZ4np-SGREObAW1STGY1+AsKxyWzGABiMChXxJAkAimSC7wgP4-jCjAzJGlSRoCgA4jAHLkgKzxavI5JM305wRZ5oaHLB55kXAai4PQCwYlUJBIDkUbML1iD7S+fBVpkhBWPa5A7DwRQIOs5Qw-M-AefghBFEcgMeRItw9va-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-xAA";
    static String observerText = "jgEHUBYIYC4AQMYQHYwJ4HsCuMoFMA2eMAtjjBAEaaxRgCWAzjAOYQkD8guAQA0qmZ9Aax4AHNHlq48KAHQwYAeQBm8TACd6OHuiwDEaAO4wcANxyqUNWoibYwZ0g2xoYug2UoZqdRixKyAogCOGBAEKFp8GIgAJmb0UEjRttC2pPTBEPoCVjZMGAQw5DiKaKqk2jwQxBAI5GXEtAAeMGjKoYTaqi14SYqqtDgx9DwIyHqwNVAhYTD0EChkiBZ01jAYGor5hTUCsgBCnqn1EPX0aCS2OYxoiGm0RMJSMAAi8v4AypUxs8I4ENmrKDOTrwSCqJg4RhFEr1RRmcw5VJEGCOG6kVpI6QAHjqAD4capccB3gBFEAAQRAAGkAIR0ukwACqADUYCB3gAZAASAC0OTAAHJcgAq-J55OZIBgPK5AGF+XseTAAEoABXe7xgiulEql5PkqqVAEk9gBNABiWp59Lp3FSTlUJEQuCSeQK9DA-RwAnoshgpr4emiPBomCYYCgmzC2LxBNxyr+4igC0U4mEvrjcYDGC6cFoqjgGAkjA0OGRQNmcFUrHIeBwskzeOzZH0J0GkKheDQ9DOREYwgg8UYNFI4iIEjixD+zqcLhwOGEvCwmTbLWUNyeaOw93wVk0iySG4WoY0LWQI5g-XDsHotFia-tIHafubZVCtAAXqQL-JyBpVKY6gwJApgqM6qhiHWSQgiYZgLJMtA3DwGCLlEUC0IQej6LIApuNoZCwmU9YwMKdgwMAexoFAHCFJ4QLII4egwF21hmE4TBMFBMaEnGpGkL+-6AYwIGkJMODRLIfEwOSBTmtAdhdI4cCQKxEkkQpDiMExrYLP4+a0AIXTRGgkIwOMLhYZcvpyI2hLNnUAypgsrbxN+O4wPoDArDYILCBBTDVkQ46rO0BjiUus6Fuo+7kIcIKym+QKqDwzyQgOi6yhI0BoDwLkwMEE7wHWJxnvaZyqFA1zKEUIGIV0EDCH5aB+bQ0CkDCZDMWFuZ4IOjB5uhX6INx+J4kaiCuRAwYRbesDGfoyA3PaVZRMpCzjs0GL0JZiQonAxF8fUjHOOhJDiLcHkaZc1g+M40S0IocJlM6Ughldx1kHA6FLfhozYP837OMpSAQosyw5LI7zAnwJBlE8rYSA2sZ4np-SGREObAW1STGY1+AsKxyWzGABiMChXxJAkAimSC7wgP4-jCjAzJGlSRoCgA4jAHLkgKzxavI5JM305wRZ5oaHLB55kXAai4PQCwYlUJBIDkUbML1iD7S+fBVpkhBWPa5A7DwRQIOs5Qw-M-AefghBFEcgMeRItw9va-gxH6tm4lypDGZCiCAJgEsCuIYJOGBWjzzDwGKyzmGgU0YpjSxBGDhkuXSIBgRDkDAsT0AO+YRZAuDAfcMAAFbrBMzESFAdaFBIxClO1pRl4we7COhUyxLIzb6PYtEYdQzhR8e3jMKw+4VjgjT7YQKQSCGziz-t4V0MihuweYMCiD2tC1qQOmQ84+hgAsjhN2REKVbOHp7geS6B6cUxwAI2xv8B9hsN7ABQMC+zziZbawdChUQUv9PAAIbAVgvG6PAwxH4PVSOtAGZk0AMFMjLTww47DIlaIoWQgDJiMHENTFEt8963kPrOAU8gmYOy7PEUqlhSGJD9IAgugxoiMB0k4ZwRAMDKW3BcD0aAqKIgvPEasrFaI2HbOOSEpscDmwTg+OO0UeBkX9iA2Ab5xBfgoYwKoogrD1w7A0RAtAWCADICEacZwDQHsU2PgcJ8CzASOhOAKJkAgjzAWIst9BwZzzpCfMTsoqnisFWP4GhrKowMkTGgKQSa-DrD2ZCGh0lsJQBQKgedVBRF2OpFIpiXodh4PmOGJgkBQEqQ8Kigw9E4CKIQM+zgyibDibOKWQD7RbgSIIL+HlgmKGxrOYyRDgnFVULcJI4dZxEEHLgLoF5mQYMpp6MMYBkiwDKeYt2wVrFT0kmRDku0yiyyYFYr8wly7BOLDAAAssstihsqh8KbrcQCl4VFoGuZ+cK2hZCpQLoVEEaByDGEQusWYKEzB1QkBfZAglJFkRkoQOSI5VDOMJEaKAgdriICeMFTwpk0IYXtIoKwoRmD5ANlCHMAwki7XNIMfoiljGNQgjUOwalmyh0KDgKAKzkjnmcKk78JddktD-OhRAbUgFMFyiTCKNx9pgVvLEMolNnAOyqH0AYMRcqYB6EK9wDcKyxDhCkBJhkAjJ1sNs4ZZQNCwF+pgcpbtTqmXeYTB1gwnVpx2fhAeL8hHv3FjspAaxEBFGgBQBuvhiL+EdRLdOobB57EZEaDkTMKzxtgIjb2dqjLANmOcYV3lZX0CiuJRObLEAcqAQHUBs8GBQD7pEGIcQEjfAvPdR69gtakCKFAAegbkkTG+LDfACwiiIliFNAI+lDLMT+KYRBflITZ0TceZwTATo7wrOaAAjAADRIlyU9moo32ldbADEF5cCsBlfEDChASgEFJvaeQZqnwoF9L-X+zZVyhDRLi3EGKQnwJgIa7hxj6hLokiWtNZEFUFgYLeZhxkbCOEPbcSDoHjgsXrH-VNk6SangHvmJIZizBdl+EBJaF5znfFXAR-cZCpUpBo6oaCds3DvkGDHVZ0qkzmOqEFWlssJqlE7TAb2IAJA7KYvdaRCEbiIKblTUy9AcwtVvNYJ4EnLXuQ6vhCs1LviI2khrP4wUbCUEaCIE4sASAJDwK5iqZ59oAFpxDQtWPocRal8WEubiR2goFkm+L4G2RO+ES4OBrqZ0dtnwv9SYWxWB6LZLyRyypCKbYu0YGfmkdCBQuy5K80nQNyDS1YyhMK6sKB173FKyia5LcQnJcfkUJghsKzJzMIqi8kKK4qLqf04lisR0Bei2ixEZQllWERCxsiUdbiwCKFq0yF46hIGUqZJ9ZE5gxKSKaDi0Rqy3gNpVfAhDFPI0JPIaWDhEDCEOLEaF+0Ma-KmuRWK5jVAAH1yA0X9HwKw-4i1FudCdM7XYFP4t3r1QDFaohqW9us2g+1EG9mFTuRggjbxwEqAUKuOcoKP3U0lF0nWse9t2lOsgsBirMMJw+JujgRbljIuAtie2HwXifAQAN72zz7elW2IOExTiVoWeOVQEFmPKEsDdIV6AbOdu9s2ESaOmmK3V+5CsJA3YnE9UkO9F40tgJc4-R4RuHxEAkcYaAiFxWlfK6Erh1ZS4VjsCVJACxyqPuUMYDB2t1Kjl2o4IEK9lIYJCt8AqwrnYSy8GkK3VUyoZCyIieB1wxOkFnhgIoMi5r-L9KjtxCDpAN8gGhetPjOp8NZ1fKacvLr1dgHlWWgFwqG3DN2SqSMeJ4lIo4e6tLSx9lnJ0usX1gJuCWUsGAke8emU8gURh8x7B0cWsgP4wjBc4vUqiC6c-hzODEWHNwdP5PhRHCgQOu-iKOPddDz7hwlkiriMvDlBnjsifjsnWP-l0AQnBhBMiFUO7uIEkAOD2MIJ6IOKQH-ishDFDlgE0oVuiFCjClpLPOzsKisrnsAFRDRLtDfJ1K7vUHADMgDvdNYKbIcO+u-trkkLLA8GUHYBNJ7pBuaDSmEP9jQReAwX8F0JcqUMwUwH6MAMDnWGDpQFAKDg1GIP8igBwOPqNISO8BgNELELNv9kzuoH2kkOMN5NIL-EAA";
    static String inheritanceText = "jgEHUBYIYC4AQMYQHYwJ4HsCuMoFMA2eMAtjjBAEaaxRgCWAzjAOYQkD8guAQA0qmZ9Aax4AHNHlq48KAHQwYAeQBm8TACd6OHuiwDEaAO4wcANxyqUNWoibYwZ0g2xoYug2UoZqdRixKyAogCOGBAEKFp8GIgAJmb0UEjRttC2pPTBEPoCVjZMGAQw5DiKaKqk2jwQxBAI5GXEtAAeMGjKoYTaqi14SYqqtDgx9DwIyHqwNVAhYTD0EChkiBZ01jAYGor5hTUCsgBCnqn1EPX0aCS2OYxoiGm0RMJSMAAi8v4AypUxs8I4ENmrKDOTrwSCqJg4RhFEr1RRmcw5VJEGCOG6kVpI6QAHjqAD4capccB3gBFEAAQRAAGkAIR0ukwACqADUYCB3gAZAASAC0OTAAHJcgAq-J55OZIBgPK5AGF+XseTAAEoABXe7xgiulEql5PkqqVAEk9gBNABiWp59Lp3FSTlUJEQuCSeQK9DA-RwAnoshgpr4emiPBomCYYCgmzC2LxBNxyr+4igC0U4mEvrjcYDGC6cFoqjgGAkjA0OGRQNmcFUrHIeBwskzeOzZH0J0GkKheDQ9DOREYwgg8UYNFI4iIEjixD+zqcLhwOGEvCwmTbLWUNyeaOw93wVk0iySG4WoY0LWQI5g-XDsHotFia-tIHafubZVCtAAXqQL-JyBpVKY6gwJApgqM6qhiHWSQgiYZgLJMtA3DwGCLlEUC0IQej6LIApuNoZCwmU9YwMKdgwMAexoFAHCFJ4QLII4egwF21hmE4TBMFBMaEnGpGkL+-6AYwIGkJMODRLIfEwOSBTmtAdhdI4cCQKxEkkQpDiMExrYLP4+a0AIXTRGgkIwOMLhYZcvpyI2hLNnUAypgsrbxN+O4wPoDArDYILCBBTDVkQ46rO0BjiUus6Fuo+7kIcIKym+QKqDwzyQgOi6yhI0BoDwLkwMEE7wHWJxnvaZyqFA1zKEUIGIV0EDCH5aB+bQ0CkDCZDMWFuZ4IOjB5uhX6INx+J4kaiCuRAwYRbesDGfoyA3PaVZRMpCzjs0GL0JZiQonAxF8fUjHOOhJDiLcHkaZc1g+M40S0IocJlM6Ughldx1kHA6FLfhozYP837OMpSAQosyw5LI7zAnwJBlE8rYSA2sZ4np-SGREObAW1STGY1+AsKxyWzGABiMChXxJAkAimSC7wgP4-jCjAzJGlSRoCgA4jAHLkgKzxavI5JM305wRZ5oaHLB55kXAai4PQCwYlUJBIDkUbML1iD7S+fBVpkhBWPa5A7DwRQIOs5Qw-M-AefghBFEcgMeRItw9va-gxH6tm4lypDGZCiCAJgEsCuIYJOGBWjzzDwGKyzmGgU0YpjSxBGDhkuXSIBgRDkDAsT0AO+YRZAuDAfcMAAFbrBMzESFAdaFBIxClO1pRl4we7COhUyxLIzb6PYtEYdQzhR8e3jMKw+4VjgjT7YQKQSCGziz-t4V0MihuweYMCiD2tC1qQOmQ84+hgAsjhN2REKVbOHp7geS6B6cUxwAI2xv8B9hsN7ABQMC+zziZbawdChUQUv9PAAIbAVgvG6PAwxH4PVSOtAGZk0AMFMjLTww47DIlaIoWQgDJiMHENTFEt8963kPrOAU8gmYOy7PEUqlhSGJD9IAgugxoiMB0k4ZwRAMDKW3BcD0aAqKIgvPEasrFaI2HbOOSEpscDmwTg+OO0UeBkX9iA2Ab5xBfgoYwKoogrD1w7A0RAtAWCADICEacZwDQHsU2PgcJ8CzASOhOAKJkAgjzAWIst9BwZzzpCfMTsoqnisFWP4GhrKowMkTGgKQSa-DrD2ZCGh0lsJQBQKgedVBRF2OpFIpiXodh4PmOGJgkBQEqQ8Kigw9E4CKIQM+zgyibDibOKWQD7RbgSIIL+HlgmKGxrOYyRDgnFVULcJI4dZxEEHLgLoF5mQYMpp6MMYBkiwDKeYt2wVrFT0kmRDku0yiyyYFYr8wly7BOLDAAAssstihsqh8KbrcQCl4VFoGuZ+cK2hZCpQLoVEEaByDGEQusWYKEzB1QkBfZAglJFkRkoQOSI5VDOLsnwSwiB355MOAs-Z2SKFY2MQUIogxZDgAWPdJIoL0pgOxdUaBnUIKUC8UVLcGIEmGRRMofCA96hMAwYCZwYyMJgx0tZPiCx6ArXIEUJIcBirIHaA+AVqhA7CVKP0GhqZMiIKmLMoFfAzEnTIneRMXVDAIFcrMMwxhal90DNvSB79jafwrCCeg8L+ilEYAACjPrQYRjht7oFuAASgxnnDC1imlPF+KoGEyIQQQTrInfCq5VqxJyE8LsuTCCwLIu8OsC5ETvDML8Z0b1SBYogbtJ54C2IYgxThPlyhkmwDyrElMbdmUNQmTlQoKiIAWwfAssRb8i0phKiLcsJMomxFCIwHV2BClPAYH6DkE5qwzGCWcJawSyInH6KYQ8yAJ7nJiDwasbLkmap7NnREE8xnOmWRG0J8QrALG0TIolXVYBbTQNEKou0RzIAHD2cK+T3m7wwNEaIDcMQTwMMgaIEExB+n9PIRktt6gXgGSdHMt7HCUEXs6ZwHyIDiuGgRojorvxkTIxOpghtLmFIkIieB1lTSEeI2x9EF0KwkBwBMb40IvTfBDbtANf4cDBBTQsIoABaBRKBY0wHNIMfoOKYDeyhri3E9KzP0pRJu-SgqKANwrDUWWDxxAekuikX6SBxh0vPtZ4Z9mnbFBhAc+gTwigpFYcxXa+ERK70wDEC1mMSAJAIL+uwU0yAsCsMwjqZ8UhuIQbXchA9vTWTZL51jEVem3HEuFZBnmxhUT6U3WKsAZaYB6GZrdFtcGkGFIU0gqpuoPnWXeR+sQ6zyz0wZouy6jCNAYLgLWolvjFVMBmZGeLlzHBYvWb2zZVwUESGiCS+3LWIAUk3C8UABtTlVqsDExgNmP1XFU-ANTnRIx4niX+QA";
    static String gigglesnortText = "jgEHUBYIYC4AQMYQHYwJ4HsCuMoFMA2eMAtjjBAEaaxRgCWAzjAOYQkD8guAQA0qmZ9Aax4AHNHlq48KAHQwYAeQBm8TACd6OHuiwDEaAO4wcANxyqUNWoibYwZ0g2xoYug2UoZqdRixKyAogCOGBAEKFp8GIgAJmb0UEjRttC2pPTBEPoCVjZMGAQw5DiKaKqk2jwQxBAI5GXEtAAeMGjKoYTaqi14SYqqtDgx9DwIyHqwNVAhYTD0EChkiBZ01jAYGor5hTUCsgBCnqn1EPX0aCS2OYxoiGm0RMJSMAAi8v4AypUxs8I4ENmrKDOTrwSCqJg4RhFEr1RRmcw5VJEGCOG6kVpI6QAHjqAD4capccB3gBFEAAQRAAGkAIR0ukwACqADUYCB3gAZAASAC0OTAAHJcgAq-J55OZIBgPK5AGF+XseTAAEoABXe7xgiulEql5PkqqVAEk9gBNABiWp59Lp3FSTlUJEQuCSeQK9DA-RwAnoshgpr4emiPBomCYYCgmzC2LxBNxyr+4igC0U4mEvrjcYDGC6cFoqjgGAkjA0OGRQNmcFUrHIeBwskzeOzZH0J0GkKheDQ9DOREYwgg8UYNFI4iIEjixD+zqcLhwOGEvCwmTbLWUNyeaOw93wVk0iySG4WoY0LWQI5g-XDsHotFia-tIHafubZVCtAAXqQL-JyBpVKY6gwJApgqM6qhiHWSQgiYZgLJMtA3DwGCLlEUC0IQej6LIApuNoZCwmU9YwMKdgwMAexoFAHCFJ4QLII4egwF21hmE4TBMFBMaEnGpGkL+-6AYwIGkJMODRLIfEwOSBTmtAdhdI4cCQKxEkkQpDiMExrYLP4+a0AIXTRGgkIwOMLhYZcvpyI2hLNnUAypgsrbxN+O4wPoDArDYILCBBTDVkQ46rO0BjiUus6Fuo+7kIcIKym+QKqDwzyQgOi6yhI0BoDwLkwMEE7wHWJxnvaZyqFA1zKEUIGIV0EDCH5aB+bQ0CkDCZDMWFuZ4IOjB5uhX6INx+J4kaiCuRAwYRbesDGfoyA3PaVZRMpCzjs0GL0JZiQonAxF8fUjHOOhJDiLcHkaZc1g+M40S0IocJlM6Ughldx1kHA6FLfhozYP837OMpSAQosyw5LI7zAnwJBlE8rYSA2sZ4np-SGREObAW1STGY1+AsKxyWzGABiMChXxJAkAimSC7wgP4-jCjAzJGlSRoCgA4jAHLkgKzxavI5JM305wRZ5oaHLB55kXAai4PQCwYlUJBIDkUbML1iD7S+fBVpkhBWPa5A7DwRQIOs5Qw-M-AefghBFEcgMeRItw9va-gxH6tm4lypDGZCiCAJgEsCuIYJOGBWjzzDwGKyzmGgU0YpjSxBGDhkuXSIBgRDkDAsT0AO+YRZAuDAfcMAAFbrBMzESFAdaFBIxClO1pRl4we7COhUyxLIzb6PYtEYdQzhR8e3jMKw+4VjgjT7YQKQSCGziz-t4V0MihuweYMCiD2tC1qQOmQ84+hgAsjhN2REKVbOHp7geS6B6cUxwAI2xv8B9hsN7ABQMC+zziZbawdChUQUv9PAAIbAVgvG6PAwxH4PVSOtAGZk0AMFMjLTww47DIlaIoWQgDJiMHENTFEt8963kPrOAU8gmYOy7PEUqlhSGJD9IAgugxoiMB0k4ZwRAMDKW3BcD0aAqKIgvPEasrFaI2HbOOSEpscDmwTg+OO0UeBkX9iA2Ab5xBfgoYwKoogrD1w7A0RAtAWCADICEacZwDQHsU2PgcJ8CzASOhOAKJkAgjzAWIst9BwZzzpCfMTsoqnisFWP4GhrKowMkTGgKQSa-DrD2ZCGh0lsJQBQKgedVBRF2OpFIpiXodh4PmOGJgkBQEqQ8Kigw9E4CKIQM+zgyibDibOKWQD7RbgSIIL+HlgmKGxrOYyRDgnFVULcJI4dZxEEHLgLoF5mQYMpp6MMYBkiwDKeYt2wVrFT0kmRDku0yiyyYFYr8wly7BOLDAAAssstihsqh8KbrcQCl4VFoGuZ+cK2hZCpQLoVEEaByDGEQusWYKEzB1QkBfZAglJFkRkoQOSI5VDOMJL-U08hGQAHJlT+EFPQ6SHJ5ACn8DwAlxLSXkqZkaZUpKOT+GZLzJm9KSVkroUzGAcY5DCuFeSKlNK6WEt5UymALK2Ucq5SKoVIr-RSsZfyyl1LaWqoZXyilcr-Dss5QKblaq9VMzFVqyVuqZVxgNUaxVPL1UUstRKnV0qNX2oVSa91zqLXirJTZPEKqYDWo9fq1lhqFVBsJCGwUpqbUatddqp15rZWRodT61NMrk1hr9em+VxqE3hv9Va31aavVFvLTmgNPA43CuzZ6jNgblUqqrY2l1tbq1NsLY6s1Nay0duZc29tcZ+1JqpYK4Nca3VDoLVG419aSLds7YO8dEbe1ZvXaW2d2752ZuLfm3NK7h2bsPWm49MbcRxrnZWvtibV27ofTulNaq4wVpHfektV763HtvZ+rdz7NVPu-XewD36-39sg0BsD56B0gfzbBk9wHX0wYA3Bida60NnuQ9B0D6HcNdv-cqH9IaF1fqPURvdSG514cQwR2jVHsPkfA5RrD+H5VxnbXuujH6cOMfY-R-jPGmMcZYxhx9qGSWkZVXx8T76D2EcE3JmTIrFONrHS+vNcn1MieUzKmjemEM6e9RJrTyHDNAd4wZhjaqVWtvjUp4zNnhNWdE0J8TTmpMed025-TPbPMCecwF3zEH3Mme41Zpd4WXOBaM95iLFGL0xYC3GULbHgsbri35zLp7yNxmY+l5L-mstFfgwl2LZXMO5f3aZrz2nKt1aCxVkLTX4sNdU3IYj2Wwslby1VyTDXWuRd6zVyzo2WtZbS21nLk3+szYm0N0rC2MtzdqyN1bS35sbeK2N2zs2tvraS+Vw743NsWf24ti7rmrvdYG+Zu7K2l27bW2dl7p3Lvnceztk712etfeoyO4VDm5ApeWz96rr3Pvvb+-dlDH2bsA8KytmH33juQ4R-91HgPEfY+RxDwbsOUe-ce++gnD2cdY5J5TuH1nhvo8J2j1jIORW49+8D6dIqmdmfh0T8nvPuf1b5wzin+ORcC5p8TjHwvWMXs0xLsXW6Cu3cl-zun4Pxfq+25rsH2vZfU4Ze+xravdeyqXdDg3Ynaem7e5bnzUvGeq5131o7+vpfc9-kaKAgdrgCHmLII0zAcBeBSNoZ+7VCnSOxn6I0gdkQACkSO7Vj8iJgGDAQr0aFHQ2CyKxvk2aQMozCMSsI8aUGQf9-A1B2b1FAbzjEiN3LcWQGKCLfkKTFQ4Z9aDCMcBeIg3ZYCAAwCapxhamBxRA3pZUAVkPl8nEX4X1aCmEqboihP9kZ4vJN8WOag1EHHMaoSisBHArnqCXvBZACA8D+MI3a28Fi3msA3U6TfNK716nkREG8A+wC5OSTUCsB2UvHSROQPNxQgfRJ4Y2XoNuDeU2Q4GWJAUBBIKBWcASMwISNYRAbJM3YyChPuPgdoeAJAQoBwFFARJABYe6R6ewGcV-c6UyCARQWfZ8NkEuFEZQXsdEZQfCESIOPZHMB6AYJIAUO8EmDiVAYPNgBQIyO8ChWiWAI8MgFgtiMeREKoLsJQ5QKlJ5IWGQ+QeqY4PAfPBYdQwEM5axCMbmZPLGZOUBJZe8OvKANgX+b2KGBQyASmZwRhAyb8CeWw1JS2LAKIWIdQBIT2GANwzfXEQPLwiZZwYg5JG8AcZEaEFuWcG+WcC8SgGfUWDSHgMZLoQYbZHxe0Bgh+ZIiKOOHoX5KaKybAWeKAP0KdHiPET3b3LSKiTqAKP4QQj8D8OsSpZQFPZgZfREfCD5a2fJK8awrCBA2AQPVsZ0cKC8EcEgKqFoP8KKJFR+Co12WcXwlZdoBYOgcMcQa8deewJGNovFWUcQT+C8EoAgAwREfQUoHhWcYwDZFoQ4NYncRgxgMoPySEJpcKcgceMsAALhsgLlIPkIAF4YA+gBgYhcRzRlQjR-A+YsQAB6OExAXEHgLEAklEJIJEyFQSMwXEeQPYd4fwZUZkBkvEgkokkkgcBickr+fMa9dmLkBko0YUXmWUfwFkjkokwVUkxEsYjidJPQCqXEDmI0DmDmdld4OhZUYUBsfE8Uq9BxEuEFeQ-CSwRAd+WPHGCCRcC8b4+Q9Yo+OwZAAecPK-Uwho2IBcMoiQGQ0iS+XBUgbhREDqKoDmIse8DEdZO8QgrAUYUBe+C6TQqwpQ50E6QpGgKMkgxaHAhYMoAfUCKo7vYRfCfA8yZY5ouQbfJIJYzAHoAQowRoSYJ4S5c4J0SmSPdCEKJYLcdpIqCAe4P0hYWUXmYmB+BM68FhVMsAWQDkRMjM2uYiX+IAA";

    static List<String> happyHellos = <String>["BORK!!!!!","HI HI HI we are FRIENDS!!!!!","ITS YOU ITS YOU ITS YOU ITS YOU ITS YOU!!!!","treat????? TREAT!!!!!","you're so good!!!! way better than the REAL guide!!!!!"];
    static List<String> neutralHellos = <String>["BORK!!!!!","FRIEND?????","!!!!! a friend?????  A FRIEND!!!!!"];
    static List<String> angryHellos = <String>["BORK!!!!!","GRRRR!!!!!","go AWAY!!!!!"];
    //bork goes with everything, add things to these sections based on stats
    static List<String> _happyPhrases = <String>["BORK!!!!!","my WHOLE BODY is a big TAIL and I am WAGGING it for my FRIEND!!!!!","BEST FRIEND I WISH I HAD MORE THAN BUGS TO FEED YOU!!!!!","i wish i HADNT EATEN ALL THE NOT-BUGS so you could have some GOOD CRUNCH!!!!!"];
    static List<String> _neutralPhrases = <String>["BORK!!!!!","boy these CHAINS get REALLY REALLY REALLY REALLY REALLY cold here!!!!!"];
    static List<String> _angryPhrases = <String>["BORK!!!!!","GRRRR!!!!!","i HATE you!!!!!","you're BAD and UNIMPORTANT and FAKE and NO ONE LIKES YOU!!!!!","you can't just TAKE THEM AWAY FROM ME!!!!!","put them BACK!!!!! they aren't HAPPY in the GROUND!!!!!","You're just a FAKE GUIDE!!!!! You aren't IMPORTANT and you can't BEAT ME!!!!!","BORK BORK BORK BORK BORK!!!!!","you're FAKE and UNIMPORTANT and IRRELEVANT and NONE OF THIS EVEN MATTERS!!!!","you aren't a REAL player!!!!!"];

    //add specific things to this on the fly
    static List<String> get happyPhrases {
        GameStats gs = Game.instance.gameStats;
        List<String> ret = new List.from(_happyPhrases);
        if(gs.helplessBugsKilled > 13) {
            ret.add("CRUNCH CRUNCH CRUNCH CRUNCH CRUNCH goes bugs!!!!!");
            //ret.add("");
            ret.add("BEST FRIEND likes crunching BUGS too!!!!!");
            ret.add("BUGS are so CRUNCHY and BEST FRIEND gets it!!!!!");
            ret.add("give me the CRONCH and i'm yours forever!!!!!");
        }else {
            ret.add("BEST FRIEND BEST FRIEND you HAVE to try BUG CRUNCHING sometime!!!!!");
        }
        return ret;
    }

    //layer them.
    static void printText(Element container){
        DivElement me = DivElement()..classes.add("ending");
        container.append(me);
        String ft = LZString.decompressFromEncodedURIComponent(friendText);
        String ot = LZString.decompressFromEncodedURIComponent(observerText);
        String ht = LZString.decompressFromEncodedURIComponent(inheritanceText);
        String gt = LZString.decompressFromEncodedURIComponent(gigglesnortText);

        DivElement friend = new DivElement()..setInnerHtml("<h1>Friend</h1>$ft")..classes.add("story");
        DivElement observer = new DivElement()..setInnerHtml("<h1>Observer</h1>$ot")..classes.add("story");
        DivElement heir = new DivElement()..setInnerHtml("<h1>Inheritance</h1>$ht")..classes.add("story");
        DivElement gigglesnort = new DivElement()..setInnerHtml("<h1>Gigglesnort</h1>$gt <br><br>WARNING: IF YOU VOID OUT GIGGLESNORT YOU VOID OUT YOUR ABILITY TO CONTROL WITHOUT WASTING. But. Of course. You need to see the text. I'm not going to just give you the answer to this puzzle with no work now, am I ;) ;) ;)")..classes.add("story");

        me.append(friend);
        me.append(observer);
        me.append(heir);
        me.append(gigglesnort);
        querySelector("#friend").onClick.listen((Event e) {
            if(!friend.classes.contains("void")){
             friend.classes.add("void");
            }else{
                friend.classes.remove("void");
            }
            window.scrollTo(0,0);
        });

        querySelector("#heir").onClick.listen((Event e) {
            if(!heir.classes.contains("void")){
                heir.classes.add("void");
            }else{
                heir.classes.remove("void");
            }
            window.scrollTo(0,0);
        });

        querySelector("#observer").onClick.listen((Event e) {
            if(!observer.classes.contains("void")){
                observer.classes.add("void");
            }else{
                observer.classes.remove("void");
            }
            window.scrollTo(0,0);
        });

        querySelector("#gigglesnort").onClick.listen((Event e) {
            if(!gigglesnort.classes.contains("void")){
                gigglesnort.classes.add("void");
            }else{
                gigglesnort.classes.remove("void");
            }
            window.scrollTo(0,0);
        });

    }

    //add specific things to this on the fly
    static List<String> get neutralPhrases {
        GameStats gs = Game.instance.gameStats;
        List<String> ret = new List.from(_neutralPhrases);
        if(gs.helplessBugsKilled <= 13) {
            ret.add("????? you don't like BUG CRUNCHING??????");
        }
        return ret;
    }

    //add specific things to this on the fly
    static List<String> get angryPhrases {
        GameStats gs = Game.instance.gameStats;
        List<String> ret = new List.from(_angryPhrases);
        if(gs.helplessBugsKilled == 0) {
            ret.add("MEANIE!!!!! you won't crunch stupid bugs but you WILL HURT MY FRIENDS?????");
        }
        for(Tombstone t in gs.theDead) {
            if(t.npcName.contains("Ebony")) ret.add("SPOOKY FRIEND was my FRIEND and she WANTED TO BE CRUNCHED!!!!!");
            if(t.npcName.contains("Skol")) ret.add("BORK FRIEND understood how TASTY BIRDS are!!!!!");
            if(t.npcName.contains("Roger")) ret.add("LAW FRIEND could tell you!!!!! I didn't break ANY laws!!!!!");
            if(t.npcName.contains("Halja")) ret.add("SMUG FRIEND was the ONLY ONE who UNDERSTOOD ME and you BURIED HER!!!!!");
            if(t.npcName.contains("Kid")) ret.add("COWBOY FRIEND knew I was a LITTLE DOGGY and you TOOK HIM FROM ME!!!!!");
        }

        if(gs.theDead.length >=5) {
            ret.add("they are MY friends not YOURS!!!!! I'm the one who brought them back!!!!!");
            ret.add("of COURSE they are my FRIENDS!!!!! I SAID I was SORRY!!!!!");
            ret.add("It's not my FAULT they looked TASTY!!!!! and I BROUGHT THEM BACK so they can't be ANGRY at me!!!!!");
        }
        return ret;
    }

    static void wakeUP(Element container) {
        sayHello(container);
        int time = new Random().nextIntRange(1000,10000);
        gullsGratitude(container);
        new Timer(new Duration(milliseconds: time), () =>
            beChatty(container));
    }

    static void gullsGratitude(Element container) {
        GameStats gs = Game.instance.gameStats;
        for(Tombstone t in gs.theDead) {
            if (t.npcName.contains("Ebony")) gullPopup(
                "Ebony: FINALLY, I FEEL DEATH'S COLD EMBRACE ONCE AGAIN!!!!!",
                container);
            if (t.npcName.contains("Sköll")) gullPopup(
                "Sköll Svelger: YOU DID IT, I ALWAYS BELIEVED IN YOU CHAMP!!!!!", container);
            if (t.npcName.contains("Roger")) gullPopup(
                "Roger: FINALLY, THE DEAD ARE BACK TO THEIR PROPER ZONING!!!!!",
                container);
            if (t.npcName.contains("Halja")) gullPopup(
                "Halja: AS I WAS TRYING TO TELL YOU, WE WERE ALWAYS DEAD.NOW WE MAY FINALLY STOP WEARING THESE EMBARASSING SKELETAL FORMS!!!!!",
                container);
            if (t.npcName.contains("Kid")) gullPopup(
                "The Kid: FINALLY I CAN GO BACK TO FARMING ALL THESE GODDAMN ICEBLOCKS IN THE AFTERLIFE!!!!!",
                container);
        }
    }

    static void beChatty(Element container) {
        chat(container);
        int time = new Random().nextIntRange(1000,10000);
        new Timer(new Duration(milliseconds: time), () =>
            beChatty(container));
    }

    static void chat(Element container) {
      List<String> choices;
      String op = opinion;
      if(op == HAPPY) choices = happyPhrases;
      if(op == NEUTRAL) choices = neutralPhrases;
      if(op == ANGRY) choices = angryPhrases;

      popup(new Random().pickFrom(choices), container, null,0,new Random().nextIntRange(50, 200), new Random().nextIntRange(50, 400));
    }

    static void sayHello(Element container) {
        List<String> choices;
        String op = opinion;
        if(op == HAPPY) choices = happyHellos;
        if(op == NEUTRAL) choices = neutralHellos;
        if(op == ANGRY) choices = angryHellos;
        popup(new Random().pickFrom(choices), container);
    }

    static Future<void> popup(String text, Element container,[DivElement currentPopup, int tick=0,int x =170, int y=80]) async {
        int maxTicks = 30;

        if(currentPopup != null && tick == 0) {
            currentPopup.remove();
            currentPopup = null;
        }

        if(currentPopup == null) {
            currentPopup = new DivElement()
                ..classes.add("fenrirPopup")
                ..text = text;
            container.append(currentPopup);
        }
        Random rand = new Random();
        rand.nextInt();
        if(rand.nextBool()) {
            currentPopup.style.left = "${x+rand.nextInt(15)}px";
        }else {
            currentPopup.style.left = "${x-rand.nextInt(15)}px";
        }
        if(rand.nextBool()) {
            currentPopup.style.top = "${y+rand.nextInt(15)}px";
        }else {
            currentPopup.style.top = "${y-rand.nextInt(15)}px";
        }
        if(tick == 1) {
            currentPopup.animate([{"opacity": 100},{"opacity": 0}], 6000);
        }

        if(tick < maxTicks) {
            new Timer(new Duration(milliseconds: 200), () =>
                popup(text, container, currentPopup, tick+1,x,y));
        }else {
            currentPopup.remove();
        }

    }

    static Future<void> gullPopup(String text, Element container,[DivElement currentPopup]) async {

        if(currentPopup == null) {
            currentPopup = new DivElement()
                ..classes.add("gullPopup")..classes.add("void")
                ..text = text;
            container.append(currentPopup);
        }
        Random rand = new Random();
        rand.nextInt();
        new Timer(new Duration(milliseconds: 20000), () =>
            currentPopup.remove());
    }

}