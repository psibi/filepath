{-# LANGUAGE CPP #-}

{- |
Module      :  System.FilePath
Copyright   :  (c) Neil Mitchell 2005-2014
License     :  BSD3

Maintainer  :  ndmitchell@gmail.com
Stability   :  stable
Portability :  portable

A library for 'FilePath' manipulations, using Posix or Windows filepaths
depending on the platform.

Both "System.FilePath.Posix" and "System.FilePath.Windows" provide the
same interface. See either for examples and a list of the available
functions.
-}
module System.FilePath
  ( module System.FilePath.Internal
  ) where

import System.FilePath.Internal
