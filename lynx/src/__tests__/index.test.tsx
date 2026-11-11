// Copyright 2024 The Lynx Authors. All rights reserved.
// Licensed under the Apache License Version 2.0 that can be found in the
// LICENSE file in the root directory of this source tree.
import '@testing-library/jest-dom';
import { render } from '@lynx-js/react/testing-library';
import { expect, test } from '@rstest/core';

import { App } from '../App';

test('App shows a spinner while photos load', async () => {
  // Never resolve, so the app stays in its loading state and makes no network call.
  globalThis.fetch = () => new Promise<Response>(() => {});

  const { findByText } = render(<App />);
  const element = await findByText('Loading photos…');

  expect(element).toBeInTheDocument();
});
