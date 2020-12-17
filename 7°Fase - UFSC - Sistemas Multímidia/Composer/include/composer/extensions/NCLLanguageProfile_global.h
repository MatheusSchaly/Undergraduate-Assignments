/* Copyright (c) 2011 Telemidia/PUC-Rio.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *
 * Contributors:
 *    Telemidia/PUC-Rio - initial API and implementation
 */
#ifndef NCLLANGUAGEPROFILE_GLOBAL_H
#define NCLLANGUAGEPROFILE_GLOBAL_H

#include <QtCore/qglobal.h>

#if defined(NCLLANGUAGEPROFILE_LIBRARY)
#  define NCLLANGUAGEPROFILESHARED_EXPORT Q_DECL_EXPORT
#else
#  define NCLLANGUAGEPROFILESHARED_EXPORT Q_DECL_IMPORT
#endif

#endif // NCLLANGUAGEPROFILE_GLOBAL_H
