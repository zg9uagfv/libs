/*
  Copyright 1999-2017 ImageMagick Studio LLC, a non-profit organization
  dedicated to making software imaging solutions freely available.
  
  You may not use this file except in compliance with the License.
  obtain a copy of the License at
  
    https://www.imagemagick.org/script/license.php
  
  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.

  MagickCore locale methods.
*/
#ifndef MAGICKCORE_LOCALE_H
#define MAGICKCORE_LOCALE_H

#include "magick/hashmap.h"

#if defined(__cplusplus) || defined(c_plusplus)
extern "C" {
#endif

typedef struct _LocaleInfo
{
  char
    *path,
    *tag,
    *message;

  MagickBooleanType
    stealth;

  struct _LocaleInfo
    *previous,
    *next;  /* deprecated, use GetLocaleInfoList() */

  size_t
    signature;
} LocaleInfo;

extern MagickExport char
  **GetLocaleList(const char *,size_t *,ExceptionInfo *);

extern MagickExport const char
  *GetLocaleMessage(const char *);

extern MagickExport const LocaleInfo
  *GetLocaleInfo_(const char *,ExceptionInfo *),
  **GetLocaleInfoList(const char *,size_t *,ExceptionInfo *);

extern MagickExport double
  InterpretLocaleValue(const char *magick_restrict,char **magick_restrict);

extern MagickExport int
  LocaleCompare(const char *,const char *),
  LocaleNCompare(const char *,const char *,const size_t);

extern MagickExport LinkedListInfo
  *DestroyLocaleOptions(LinkedListInfo *),
  *GetLocaleOptions(const char *,ExceptionInfo *);

extern MagickExport MagickBooleanType
  ListLocaleInfo(FILE *,ExceptionInfo *),
  LocaleComponentGenesis(void);

extern MagickExport ssize_t
  FormatLocaleFile(FILE *,const char *magick_restrict,...)
    magick_attribute((__format__ (__printf__,2,3))),
  FormatLocaleFileList(FILE *,const char *magick_restrict,va_list)
    magick_attribute((__format__ (__printf__,2,0))),
  FormatLocaleString(char *magick_restrict,const size_t,
    const char *magick_restrict,...)
    magick_attribute((__format__ (__printf__,3,4))),
  FormatLocaleStringList(char *magick_restrict,const size_t,
    const char *magick_restrict,
    va_list) magick_attribute((__format__ (__printf__,3,0)));

extern MagickExport void
  LocaleComponentTerminus(void),
  LocaleLower(char *),
  LocaleUpper(char *);

#if defined(__cplusplus) || defined(c_plusplus)
}
#endif

#endif
